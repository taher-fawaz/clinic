import 'package:firebase_auth/firebase_auth.dart';
import 'package:clinic/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.uId,
    super.isAdmin = false,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      isAdmin: false, // Default to false, can be updated later
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
      isAdmin: user.isAdmin,
    );
  }

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'isAdmin': isAdmin,
    };
  }
}
