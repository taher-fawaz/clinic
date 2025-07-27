import '../../domain/entities/user_entity.dart';

class PatientLoginResponseModel {
  final bool success;
  final String message;
  final PatientData? data;
  final String? token;

  const PatientLoginResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.token,
  });

  factory PatientLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return PatientLoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? PatientData.fromJson(json['data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'token': token,
    };
  }
}

class PatientData extends UserEntity {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PatientData({
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

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
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

  PatientData copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientData(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}