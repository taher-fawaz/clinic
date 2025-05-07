import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required String id,
    required String patientId,
    required String doctorId,
    required DateTime appointmentDate,
    required String status,
    String notes = '',
  }) : super(
          id: id,
          patientId: patientId,
          doctorId: doctorId,
          appointmentDate: appointmentDate,
          status: status,
          notes: notes,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      patientId: json['patientId'] ?? '',
      doctorId: json['doctorId'] ?? '',
      appointmentDate: (json['appointmentDate'] as Timestamp).toDate(),
      status: json['status'] ?? 'scheduled',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
      'status': status,
      'notes': notes,
    };
  }
}
