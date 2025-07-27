import '../../domain/entities/user_entity.dart';

class PatientRegisterModel extends UserEntity {
  const PatientRegisterModel({
    required String username,
    required String phoneNumber,
    required String password,
  }) : super(
          username: username,
          phoneNumber: phoneNumber,
          password: password,
        );

  PatientRegisterModel copyWith({
    String? username,
    String? phoneNumber,
    String? password,
  }) {
    return PatientRegisterModel(
      username: username ?? (this.username ?? ""),
      phoneNumber: phoneNumber ?? (this.phoneNumber ?? ""),
      password: password ?? (this.password ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": username,
      "phone": phoneNumber,
      "password": password,
    };
  }
}