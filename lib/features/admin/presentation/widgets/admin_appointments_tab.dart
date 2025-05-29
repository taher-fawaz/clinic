import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/admin/presentation/cubits/admin_appointments_cubit.dart';

class AdminAppointmentsTab extends StatefulWidget {
  const AdminAppointmentsTab({Key? key}) : super(key: key);

  @override
  State<AdminAppointmentsTab> createState() => _AdminAppointmentsTabState();
}

class _AdminAppointmentsTabState extends State<AdminAppointmentsTab> {
  late AdminAppointmentsCubit _appointmentsCubit;

  @override
  void initState() {
    super.initState();
    _appointmentsCubit = getIt<AdminAppointmentsCubit>();
    _appointmentsCubit.loadAppointments();
  }

  @override
  void dispose() {
    _appointmentsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _appointmentsCubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
            bottom: const TabBar(
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.pending_actions),
                  text: 'Pending Approval',
                ),
                Tab(
                  icon: Icon(Icons.history),
                  text: 'Processed',
                ),
              ],
            ),
          ),
          body: BlocConsumer<AdminAppointmentsCubit, AdminAppointmentsState>(
            listener: (context, state) {
              if (state is AdminAppointmentsOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is AdminAppointmentsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AdminAppointmentsInitial ||
                  state is AdminAppointmentsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminAppointmentsLoaded) {
                return TabBarView(
                  children: [
                    _buildPendingAppointments(state.pendingAppointments),
                    _buildProcessedAppointments(state.processedAppointments),
                  ],
                );
              } else if (state is AdminAppointmentsError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return TabBarView(
                  children: [
                    _buildPendingAppointments([]),
                    _buildProcessedAppointments([]),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPendingAppointments(
      List<AppointmentEntity> pendingAppointments) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.pending_actions, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Text(
                'Pending Appointments (${pendingAppointments.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: pendingAppointments.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 64,
                        color: Colors.green,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No pending appointments',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        'All appointments have been processed',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: pendingAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = pendingAppointments[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'PENDING',
                                    style: TextStyle(
                                      color: Colors.orange.shade800,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'ID: ${appointment.id}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Patient: ${appointment.patientId}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.medical_services,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text('Doctor: ${appointment.doctorId}'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(_formatDateTime(
                                    appointment.appointmentDate)),
                              ],
                            ),
                            if (appointment.notes.isNotEmpty)
                              Column(children: [
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Notes: ${appointment.notes}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ]),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _approveAppointment(
                                        context, appointment),
                                    icon: const Icon(Icons.check),
                                    label: const Text('Approve'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _rejectAppointment(
                                        context, appointment),
                                    icon: const Icon(Icons.close),
                                    label: const Text('Reject'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildProcessedAppointments(
      List<AppointmentEntity> processedAppointments) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.history, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Text(
                'Processed Appointments (${processedAppointments.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: processedAppointments.isEmpty
              ? const Center(
                  child: Text(
                    'No processed appointments yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: processedAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = processedAppointments[index];
                    final isApproved = appointment.status == 'approved';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              isApproved ? Colors.green : Colors.red,
                          child: Icon(
                            isApproved ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        title: Text('Patient: ${appointment.patientId}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Doctor: ${appointment.doctorId}'),
                            Text(_formatDateTime(appointment.appointmentDate)),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isApproved
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appointment.status.toUpperCase(),
                            style: TextStyle(
                              color: isApproved
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _approveAppointment(
      BuildContext context, AppointmentEntity appointment) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Approve Appointment'),
        content:
            const Text('Are you sure you want to approve this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AdminAppointmentsCubit>()
                  .approveAppointment(appointment.id);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _rejectAppointment(BuildContext context, AppointmentEntity appointment) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject Appointment'),
        content:
            const Text('Are you sure you want to reject this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AdminAppointmentsCubit>()
                  .rejectAppointment(appointment.id);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}
