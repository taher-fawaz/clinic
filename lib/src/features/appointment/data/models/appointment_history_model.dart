import 'package:equatable/equatable.dart';

enum VisitType {
  consultation,
  followUp,
  checkup,
  emergency,
  procedure,
}

class AppointmentHistoryModel extends Equatable {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final VisitType visitType;
  final double price;
  final String? notes;
  final String? diagnosis;
  final String? prescription;
  final String? followUpInstructions;
  final DateTime completedAt;
  final int rating; // 1-5 stars
  final String? patientFeedback;
  final List<String> attachments; // File URLs or paths

  const AppointmentHistoryModel({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.visitType,
    required this.price,
    this.notes,
    this.diagnosis,
    this.prescription,
    this.followUpInstructions,
    required this.completedAt,
    this.rating = 0,
    this.patientFeedback,
    this.attachments = const [],
  });

  factory AppointmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return AppointmentHistoryModel(
      appointmentId: json['appointmentId'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      visitType: VisitType.values.firstWhere(
        (e) => e.name == json['visitType'],
        orElse: () => VisitType.consultation,
      ),
      price: (json['price'] as num).toDouble(),
      notes: json['notes'] as String?,
      diagnosis: json['diagnosis'] as String?,
      prescription: json['prescription'] as String?,
      followUpInstructions: json['followUpInstructions'] as String?,
      completedAt: DateTime.parse(json['completedAt'] as String),
      rating: json['rating'] as int? ?? 0,
      patientFeedback: json['patientFeedback'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)?.cast<String>() ?? [],
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
      'visitType': visitType.name,
      'price': price,
      'notes': notes,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'followUpInstructions': followUpInstructions,
      'completedAt': completedAt.toIso8601String(),
      'rating': rating,
      'patientFeedback': patientFeedback,
      'attachments': attachments,
    };
  }

  AppointmentHistoryModel copyWith({
    String? appointmentId,
    String? patientId,
    String? doctorId,
    String? doctorName,
    String? specialty,
    DateTime? appointmentDate,
    String? startTime,
    String? endTime,
    VisitType? visitType,
    double? price,
    String? notes,
    String? diagnosis,
    String? prescription,
    String? followUpInstructions,
    DateTime? completedAt,
    int? rating,
    String? patientFeedback,
    List<String>? attachments,
  }) {
    return AppointmentHistoryModel(
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      visitType: visitType ?? this.visitType,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      diagnosis: diagnosis ?? this.diagnosis,
      prescription: prescription ?? this.prescription,
      followUpInstructions: followUpInstructions ?? this.followUpInstructions,
      completedAt: completedAt ?? this.completedAt,
      rating: rating ?? this.rating,
      patientFeedback: patientFeedback ?? this.patientFeedback,
      attachments: attachments ?? this.attachments,
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
        visitType,
        price,
        notes,
        diagnosis,
        prescription,
        followUpInstructions,
        completedAt,
        rating,
        patientFeedback,
        attachments,
      ];

  // Helper getters
  String get timeRange => '$startTime - $endTime';
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';
  String get formattedDate => '${appointmentDate.day}/${appointmentDate.month}/${appointmentDate.year}';
  String get formattedCompletedDate => '${completedAt.day}/${completedAt.month}/${completedAt.year}';
  String get formattedCompletedAt => '${completedAt.day}/${completedAt.month}/${completedAt.year}';
  
  String get visitTypeDisplayName {
    switch (visitType) {
      case VisitType.consultation:
        return 'استشارة';
      case VisitType.followUp:
        return 'متابعة';
      case VisitType.checkup:
        return 'فحص';
      case VisitType.emergency:
        return 'طوارئ';
      case VisitType.procedure:
        return 'إجراء';
    }
  }
  
  bool get hasNotes => notes != null && notes!.isNotEmpty;
  bool get hasDiagnosis => diagnosis != null && diagnosis!.isNotEmpty;
  bool get hasPrescription => prescription != null && prescription!.isNotEmpty;
  bool get hasFollowUp => followUpInstructions != null && followUpInstructions!.isNotEmpty;
  bool get hasAttachments => attachments.isNotEmpty;
  bool get isRated => rating > 0;
}