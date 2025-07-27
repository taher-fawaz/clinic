import '../../domain/entities/user_entity.dart';

class PatientLoginModel extends UserEntity {
  const PatientLoginModel({
    required String phoneNumber,
    required String password,
  }) : super(phoneNumber: phoneNumber, password: password);

  PatientLoginModel copyWith({String? phoneNumber, String? password}) {
    return PatientLoginModel(
      phoneNumber: phoneNumber ?? (this.phoneNumber ?? ""),
      password: password ?? (this.password ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "phone": phoneNumber,
      "password": password,
    };
  }
}