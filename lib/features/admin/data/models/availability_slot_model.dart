import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabilitySlotModel {
  final String? id;
  final String dayOfWeek; // e.g., "Monday", "Tuesday"
  final DateTime startTime;
  final DateTime endTime;
  final String? doctorId; // Optional: if slots can be doctor-specific
  final bool isBooked;
  final String? bookedByPatientId; // Optional: to know who booked it

  AvailabilitySlotModel({
    this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.doctorId,
    this.isBooked = false,
    this.bookedByPatientId,
  });

  // Convert to a map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'doctorId': doctorId,
      'isBooked': isBooked,
      'bookedByPatientId': bookedByPatientId,
    };
  }

  // Create from Firebase snapshot
  factory AvailabilitySlotModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AvailabilitySlotModel(
      id: doc.id,
      dayOfWeek: data['dayOfWeek'] ?? '',
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      doctorId: data['doctorId'] as String?,
      isBooked: data['isBooked'] ?? false,
      bookedByPatientId: data['bookedByPatientId'] as String?,
    );
  }

  AvailabilitySlotModel copyWith({
    String? id,
    String? dayOfWeek,
    DateTime? startTime,
    DateTime? endTime,
    String? doctorId,
    bool? isBooked,
    String? bookedByPatientId,
  }) {
    return AvailabilitySlotModel(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      doctorId: doctorId ?? this.doctorId,
      isBooked: isBooked ?? this.isBooked,
      bookedByPatientId: bookedByPatientId ?? this.bookedByPatientId,
    );
  }
}
