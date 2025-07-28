import 'package:clinic/src/features/patient_medical_record/data/models/medical_file_model.dart';

class MedicalRecordModel {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MedicalCondition> conditions;
  final List<DoctorNote> notes;
  final List<MedicalFileModel> attachments;

  const MedicalRecordModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.createdAt,
    required this.updatedAt,
    required this.conditions,
    required this.notes,
    required this.attachments,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      patientName: json['patientName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      conditions: (json['conditions'] as List<dynamic>)
          .map((e) => MedicalCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => DoctorNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => MedicalFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'conditions': conditions.map((e) => e.toJson()).toList(),
      'notes': notes.map((e) => e.toJson()).toList(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
    };
  }

  String get formattedCreatedAt {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String get formattedUpdatedAt {
    return '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}';
  }

  int get totalConditions => conditions.length;
  int get totalNotes => notes.length;
  int get totalAttachments => attachments.length;
}

class MedicalCondition {
  final String id;
  final String name;
  final String description;
  final String severity; // 'mild', 'moderate', 'severe'
  final DateTime diagnosedAt;
  final String doctorId;
  final String doctorName;
  final bool isActive;

  const MedicalCondition({
    required this.id,
    required this.name,
    required this.description,
    required this.severity,
    required this.diagnosedAt,
    required this.doctorId,
    required this.doctorName,
    required this.isActive,
  });

  factory MedicalCondition.fromJson(Map<String, dynamic> json) {
    return MedicalCondition(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'severity': severity,
      'diagnosedAt': diagnosedAt.toIso8601String(),
      'doctorId': doctorId,
      'doctorName': doctorName,
      'isActive': isActive,
    };
  }

  String get formattedDiagnosedAt {
    return '${diagnosedAt.day}/${diagnosedAt.month}/${diagnosedAt.year}';
  }
}

class DoctorNote {
  final String id;
  final String content;
  final DateTime createdAt;
  final String doctorId;
  final String doctorName;
  final String type; // 'general', 'prescription', 'follow_up'

  const DoctorNote({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.doctorId,
    required this.doctorName,
    required this.type,
  });

  factory DoctorNote.fromJson(Map<String, dynamic> json) {
    return DoctorNote(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'doctorId': doctorId,
      'doctorName': doctorName,
      'type': type,
    };
  }

  String get formattedCreatedAt {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
}
