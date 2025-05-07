import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/widgets/custom_button.dart';
import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/appointment/domain/entities/doctor_entity.dart';
import 'package:clinic/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:clinic/features/appointment/presentation/widgets/appointment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  DoctorEntity? _selectedDoctor;

  // Dummy doctors data - in a real app, this would come from a repository
  final List<DoctorEntity> _doctors = [
    DoctorEntity(
      id: 'doc1',
      name: 'Dr. Ahmed',
      specialization: 'General Dentistry',
      availableDays: ['Monday', 'Wednesday', 'Friday'],
      bio: 'Experienced dentist providing high-quality dental care.',
      imageUrl: 'assets/images/doctor1.png',
      rating: 4.5,
    ),
    DoctorEntity(
      id: 'doc2',
      name: 'Dr. Sara',
      specialization: 'Orthodontics',
      availableDays: ['Monday', 'Wednesday', 'Friday'],
      bio: 'Experienced dentist providing high-quality dental care.',
      imageUrl: 'assets/images/doctor1.png',
      rating: 4.5,
    ),
    DoctorEntity(
      id: 'doc3',
      name: 'Dr. Mohamed',
      specialization: 'Pediatric Dentistry',
      availableDays: ['Monday', 'Wednesday', 'Friday'],
      bio: 'Experienced dentist providing high-quality dental care.',
      imageUrl: 'assets/images/doctor1.png',
      rating: 4.5,
    ),
  ];

  // Adding the missing required parameters
  final String _imageUrl = 'assets/images/doctor_default.png';
  final String _bio = 'Experienced dentist providing high-quality dental care.';
  final String _rating = '4.8';
  final List<String> _availableDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = _doctors.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitAppointment() {
    if (_formKey.currentState!.validate()) {
      // Create appointment entity
      final appointmentDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final appointment = AppointmentEntity(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // Generate a temporary ID
        patientId:
            'current_user_id', // In a real app, get this from auth service
        doctorId: _selectedDoctor!.id,
        appointmentDate: appointmentDate,
        status: 'scheduled',
        notes: _notesController.text,
      );

      // Dispatch event to create appointment
      context
          .read<AppointmentBloc>()
          .add(CreateAppointment(appointment: appointment));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment scheduled successfully!')),
      );

      // Reset form
      _formKey.currentState!.reset();
      _nameController.clear();
      _phoneController.clear();
      _notesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Appointments'),
              Tab(text: 'Book New'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // My Appointments Tab
            BlocBuilder<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentInitial) {
                  // Load appointments when the view is first opened
                  context.read<AppointmentBloc>().add(
                        const LoadAppointments(patientId: 'current_user_id'),
                      );
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppointmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AppointmentsLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upcoming Appointments',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        AppointmentList(
                          appointments: state.appointments,
                          onCancelAppointment: (appointment) {
                            context.read<AppointmentBloc>().add(
                                  CancelAppointment(
                                      appointmentId: appointment.id,
                                      patientId: 'current_user_id'),
                                );
                          },
                          onRescheduleAppointment: (appointment) {
                            // Show reschedule dialog or navigate to reschedule screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Reschedule feature coming soon')),
                            );
                          },
                          // Adding missing required parameters
                        ),
                      ],
                    ),
                  );
                } else if (state is AppointmentError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                } else {
                  return const Center(
                    child: Text('No appointments found'),
                  );
                }
              },
            ),

            // Book New Appointment Tab
            BlocListener<AppointmentBloc, AppointmentState>(
              listener: (context, state) {
                if (state is AppointmentCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Appointment scheduled successfully!')),
                  );
                  // Switch to the first tab to show the new appointment
                  DefaultTabController.of(context).animateTo(0);
                } else if (state is AppointmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Patient Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _nameController,
                        label: 'Full Name',
                        hintText: 'Enter your full name',
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        textInputType: TextInputType.phone,
                        hintText: 'Enter your phone number',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Appointment Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<DoctorEntity>(
                        decoration: const InputDecoration(
                          labelText: 'Select Doctor',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedDoctor,
                        items: _doctors.map((doctor) {
                          return DropdownMenuItem<DoctorEntity>(
                            value: doctor,
                            child: Text(
                                '${doctor.name} - ${doctor.specialization}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDoctor = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectTime(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Time',
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  _selectedTime.format(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _notesController,
                        label: 'Notes',
                        hintText: 'Enter any additional notes',
                        textInputType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AppointmentBloc, AppointmentState>(
                        builder: (context, state) {
                          return CustomButton(
                            onPressed: state is AppointmentLoading
                                ? () {}
                                : _submitAppointment,
                            text: state is AppointmentLoading
                                ? 'Scheduling...'
                                : 'Schedule Appointment',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
