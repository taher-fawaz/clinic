import 'package:equatable/equatable.dart';

enum AppointmentStatus {
  pending,
  approved,
  rejected,
}

class AppointmentStatusModel extends Equatable {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final AppointmentStatus status;
  final double price;
  final String appointmentType;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? rejectionReason;

  const AppointmentStatusModel({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.price,
    required this.appointmentType,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.rejectionReason,
  });

  factory AppointmentStatusModel.fromJson(Map<String, dynamic> json) {
    return AppointmentStatusModel(
      appointmentId: json['appointmentId'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      price: (json['price'] as num).toDouble(),
      appointmentType: json['appointmentType'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'specialty': specialty,
      'appointmentDate': appointmentDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'status': status.name,
      'price': price,
      'appointmentType': appointmentType,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }

  AppointmentStatusModel copyWith({
    String? appointmentId,
    String? patientId,
    String? doctorId,
    String? doctorName,
    String? specialty,
    DateTime? appointmentDate,
    String? startTime,
    String? endTime,
    AppointmentStatus? status,
    double? price,
    String? appointmentType,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rejectionReason,
  }) {
    return AppointmentStatusModel(
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      price: price ?? this.price,
      appointmentType: appointmentType ?? this.appointmentType,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  @override
  List<Object?> get props => [
        appointmentId,
        patientId,
        doctorId,
        doctorName,
        specialty,
        appointmentDate,
        startTime,
        endTime,
        status,
        price,
        appointmentType,
        notes,
        createdAt,
        updatedAt,
        rejectionReason,
      ];

  // Helper getters
  String get timeRange => '$startTime - $endTime';
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';
  String get formattedDate => '${appointmentDate.day}/${appointmentDate.month}/${appointmentDate.year}';
  String get formattedCreatedAt => '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  
  bool get isPending => status == AppointmentStatus.pending;
  bool get isApproved => status == AppointmentStatus.approved;
  bool get isRejected => status == AppointmentStatus.rejected;
}