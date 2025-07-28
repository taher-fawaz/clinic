import 'package:equatable/equatable.dart';

class BookAppointmentRequestModel extends Equatable {
  final String slotId;
  final String patientId;
  final String doctorId;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final String? notes;
  final String appointmentType; // 'consultation', 'checkup', 'treatment'
  final bool isUrgent;
  final Map<String, dynamic>? patientInfo;

  const BookAppointmentRequestModel({
    required this.slotId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    this.notes,
    required this.appointmentType,
    this.isUrgent = false,
    this.patientInfo,
  });

  factory BookAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentRequestModel(
      slotId: json['slotId'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      notes: json['notes'] as String?,
      appointmentType: json['appointmentType'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      patientInfo: json['patientInfo'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'notes': notes,
      'appointmentType': appointmentType,
      'isUrgent': isUrgent,
      'patientInfo': patientInfo,
    };
  }

  BookAppointmentRequestModel copyWith({
    String? slotId,
    String? patientId,
    String? doctorId,
    DateTime? appointmentDate,
    String? startTime,
    String? endTime,
    String? notes,
    String? appointmentType,
    bool? isUrgent,
    Map<String, dynamic>? patientInfo,
  }) {
    return BookAppointmentRequestModel(
      slotId: slotId ?? this.slotId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      appointmentType: appointmentType ?? this.appointmentType,
      isUrgent: isUrgent ?? this.isUrgent,
      patientInfo: patientInfo ?? this.patientInfo,
    );
  }

  @override
  List<Object?> get props => [
        slotId,
        patientId,
        doctorId,
        appointmentDate,
        startTime,
        endTime,
        notes,
        appointmentType,
        isUrgent,
        patientInfo,
      ];
}