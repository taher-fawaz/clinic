class AppointmentEntity {
  final String id;
  final String patientId;
  final String? patientName; // Added patientName
  final String? patientPhone; // Added patientPhone
  final String doctorId;
  final DateTime appointmentDate;
  final String status; // 'pending', 'scheduled', 'completed', 'cancelled'
  final String notes;

  AppointmentEntity({
    required this.id,
    required this.patientId,
    this.patientName,
    this.patientPhone,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    this.notes = '',
  });
}
