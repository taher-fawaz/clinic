import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required String id,
    required String patientId,
    String? patientName, // Added patientName
    String? patientPhone, // Added patientPhone
    required String doctorId,
    required DateTime appointmentDate,
    required String status,
    String notes = '',
  }) : super(
          id: id,
          patientId: patientId,
          patientName: patientName, // Pass to super
          patientPhone: patientPhone, // Pass to super
          doctorId: doctorId,
          appointmentDate: appointmentDate,
          status: status,
          notes: notes,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      patientId: json['patientId'] ?? '',
      patientName: json['patientName'], // Added patientName fromJson
      patientPhone: json['patientPhone'], // Added patientPhone fromJson
      doctorId: json['doctorId'] ?? '',
      appointmentDate: (json['appointmentDate'] as Timestamp).toDate(),
      status: json['status'] ?? 'pending', // Default to pending if not present
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName, // Added patientName toJson
      'patientPhone': patientPhone, // Added patientPhone toJson
      'doctorId': doctorId,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
      'status': status,
      'notes': notes,
    };
  }
}
