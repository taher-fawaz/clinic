class AppointmentEntity {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime appointmentDate;
  final String status; // 'scheduled', 'completed', 'cancelled'
  final String notes;

  AppointmentEntity({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    this.notes = '',
  });
}
