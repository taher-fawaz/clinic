import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/admin/data/models/availability_slot_model.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_availability_cubit.dart'; // To load slots
import 'package:clinic/features/appointment/presentation/cubits/appointment_cubit.dart'; // To book appointment
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To get current user ID
import 'package:cloud_firestore/cloud_firestore.dart'; // Added for fetching user data

class BookAppointmentView extends StatefulWidget {
  static const String routeName = '/book-appointment';
  const BookAppointmentView({Key? key}) : super(key: key);

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  late AdminAvailabilityCubit _availabilityCubit;
  late AppointmentCubit _appointmentCubit;
  String?
      _selectedDoctorId; // Assuming a way to select a doctor, or pre-selected
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _availabilityCubit = getIt<AdminAvailabilityCubit>();
    _appointmentCubit = getIt<AppointmentCubit>();
    _availabilityCubit.loadAvailabilitySlots();
    // TODO: Implement doctor selection or pass doctorId if pre-selected
    // For now, let's assume a default or placeholder doctor ID if needed by slots
    // _selectedDoctorId = "some_doctor_id";
  }

  @override
  void dispose() {
    // Cubits are managed by GetIt, no need to close if they are singletons
    // or if their lifecycle is managed elsewhere. If they are created here and not singletons,
    // then they should be closed.
    // _availabilityCubit.close();
    // _appointmentCubit.close();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    // Optionally, filter slots based on the new date if slots are date-specific
    // _availabilityCubit.loadAvailabilitySlots(date: _selectedDate, doctorId: _selectedDoctorId);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Handle user not logged in
      return Scaffold(
        appBar: AppBar(title: const Text('Book Appointment')),
        body: const Center(child: Text('Please log in to book appointments.')),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _availabilityCubit),
        BlocProvider.value(value: _appointmentCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Appointment'),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          children: [
            _buildDatePicker(),
            Expanded(
              child:
                  BlocConsumer<AdminAvailabilityCubit, AdminAvailabilityState>(
                listener: (context, state) {
                  if (state is AdminAvailabilityError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Error loading slots: ${state.message}'),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (context, availabilityState) {
                  if (availabilityState is AdminAvailabilityLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (availabilityState is AdminAvailabilityLoaded) {
                    final availableSlots = _filterSlotsForSelectedDate(
                        availabilityState.slots, _selectedDate);
                    if (availableSlots.isEmpty) {
                      return const Center(
                          child: Text(
                              'No available slots for the selected date.'));
                    }
                    return _buildAvailableSlotsList(
                        availableSlots, currentUser.uid);
                  }
                  return const Center(
                      child: Text('Select a date to see available slots.'));
                },
              ),
            ),
            BlocListener<AppointmentCubit, AppointmentState>(
              listener: (context, state) {
                if (state is AppointmentSuccess &&
                    state.message == 'Appointment booked successfully!') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Appointment booked successfully!'),
                        backgroundColor: Colors.green),
                  );
                  _availabilityCubit.loadAvailabilitySlots(); // Refresh slots
                } else if (state is AppointmentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Failed to book appointment: ${state.message}'),
                        backgroundColor: Colors.red),
                  );
                }
              },
              child: Container(), // Empty container for listener
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Selected Date: ${DateFormat.yMMMd().format(_selectedDate)}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: const Text('Change Date'),
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(
                    days: 365)), // Allow booking for up to a year
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                _onDateSelected(pickedDate);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }

  List<AvailabilitySlotModel> _filterSlotsForSelectedDate(
      List<AvailabilitySlotModel> allSlots, DateTime selectedDate) {
    final String selectedDayOfWeek =
        DateFormat('EEEE').format(selectedDate); // E.g., 'Monday'
    return allSlots
        .where((slot) => slot.dayOfWeek == selectedDayOfWeek && !slot.isBooked
            // Optional: Add doctorId filter if _selectedDoctorId is set
            // && (_selectedDoctorId == null || slot.doctorId == _selectedDoctorId)
            )
        .toList();
  }

  Widget _buildAvailableSlotsList(
      List<AvailabilitySlotModel> slots, String patientId) {
    if (slots.isEmpty) {
      return const Center(child: Text('No available slots for this day.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: ListTile(
            title: Text(
                '${slot.dayOfWeek}: ${DateFormat.jm().format(slot.startTime)} - ${DateFormat.jm().format(slot.endTime)}'),
            subtitle: Text(
                slot.doctorId != null
                    ? 'Doctor ID: ${slot.doctorId}'
                    : 'Any Doctor',
                style: TextStyle(color: Colors.grey[600])),
            trailing: ElevatedButton(
              child: const Text('Book Now'),
              onPressed: () => _confirmBooking(context, slot, patientId),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
            ),
          ),
        );
      },
    );
  }

  void _confirmBooking(
      BuildContext context, AvailabilitySlotModel slot, String patientId) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null)
      return; // Should not happen if already on this screen

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
            'Book appointment for ${slot.dayOfWeek} at ${DateFormat.jm().format(slot.startTime)} - ${DateFormat.jm().format(slot.endTime)} with Dr. Ahmed El Sayed?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              // Made async to fetch user data
              final appointmentDate = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
                slot.startTime.hour,
                slot.startTime.minute,
              );

              // Fetch user details from Firestore
              String patientName = currentUser.displayName ?? 'N/A';
              String patientPhone = currentUser.phoneNumber ??
                  'N/A'; // Assuming phone is stored directly

              // If not directly available, try fetching from 'users' collection
              if (patientName == 'N/A' || patientPhone == 'N/A') {
                try {
                  DocumentSnapshot userDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(patientId)
                      .get();
                  if (userDoc.exists) {
                    final userData = userDoc.data() as Map<String, dynamic>?;
                    patientName = userData?['name'] ?? patientName;
                    patientPhone = userData?['phone'] ?? patientPhone;
                  }
                } catch (e) {
                  print('Error fetching user details: $e');
                  // Proceed with default values if fetching fails
                }
              }

              final newAppointment = AppointmentEntity(
                id: '', // Leave empty for auto-generation
                patientId: patientId,
                patientName: patientName, // Added patient name
                patientPhone: patientPhone, // Added patient phone
                doctorId: 'Dr. Ahmed El Sayed', // Fixed doctor ID
                appointmentDate: appointmentDate,
                status: 'pending', // Default status
                notes:
                    'Booked via app. Patient: $patientName, Phone: $patientPhone',
              );
              _appointmentCubit.createAppointment(newAppointment, slot.id!);
              Navigator.pop(dialogContext);
            },
            child: const Text('Confirm'),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
