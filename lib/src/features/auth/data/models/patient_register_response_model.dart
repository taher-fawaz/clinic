import '../../domain/entities/user_entity.dart';

class PatientRegisterResponseModel {
  final bool success;
  final String message;
  final PatientRegisterData? data;

  const PatientRegisterResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory PatientRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return PatientRegisterResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? PatientRegisterData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class PatientRegisterData extends UserEntity {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PatientRegisterData({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
  }) : super(
          userId: id,
          username: name,
          phoneNumber: phone,
          email: email,
        );

  factory PatientRegisterData.fromJson(Map<String, dynamic> json) {
    return PatientRegisterData(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  PatientRegisterData copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientRegisterData(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}