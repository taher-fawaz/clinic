import 'package:equatable/equatable.dart';

class DoctorWorkModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String doctorName;
  final String specialty;
  final DateTime createdAt;
  final List<String> tags;

  const DoctorWorkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.doctorName,
    required this.specialty,
    required this.createdAt,
    required this.tags,
  });

  factory DoctorWorkModel.fromJson(Map<String, dynamic> json) {
    return DoctorWorkModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      beforeImageUrl: json['beforeImageUrl'] as String,
      afterImageUrl: json['afterImageUrl'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'beforeImageUrl': beforeImageUrl,
      'afterImageUrl': afterImageUrl,
      'doctorName': doctorName,
      'specialty': specialty,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags,
    };
  }

  DoctorWorkModel copyWith({
    String? id,
    String? title,
    String? description,
    String? beforeImageUrl,
    String? afterImageUrl,
    String? doctorName,
    String? specialty,
    DateTime? createdAt,
    List<String>? tags,
  }) {
    return DoctorWorkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      beforeImageUrl: beforeImageUrl ?? this.beforeImageUrl,
      afterImageUrl: afterImageUrl ?? this.afterImageUrl,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        beforeImageUrl,
        afterImageUrl,
        doctorName,
        specialty,
        createdAt,
        tags,
      ];
}