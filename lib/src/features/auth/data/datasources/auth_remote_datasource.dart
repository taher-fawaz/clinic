import '../../../../core/api/api_url.dart';
import '../../../../core/constants/error_message.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/user_model.dart';
import '../models/patient_login_model.dart';
import '../models/patient_register_model.dart';
import '../models/patient_login_response_model.dart';
import '../models/patient_register_response_model.dart';

sealed class AuthRemoteDataSource {
  Future<void> logout();

  // Patient-specific methods
  Future<UserModel> patientLogin(PatientLoginModel model);
  Future<void> patientRegister(PatientRegisterModel model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<UserModel> patientLogin(PatientLoginModel model) async {
    try {
      final user = await _getUserByPhone(model.phoneNumber ?? "");

      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> patientRegister(PatientRegisterModel model) async {
    try {
      final user = await _getUserByPhone(model.phoneNumber ?? "");
      if (user.phoneNumber == model.phoneNumber) {
        throw DuplicatePhoneException();
      }

      return;
    } on EmptyException {
      await ApiUrl.patients.add(model.toMap());
    } on DuplicatePhoneException {
      rethrow;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  Future<UserModel> _getUserByEmail(String email) async {
    try {
      final result = await ApiUrl.users.where("email", isEqualTo: email).get();
      final doc = result.docs.first;
      final user = UserModel.fromJson(doc.data(), doc.id);

      return user;
    } catch (e) {
      if (e.toString() == noElement) {
        throw EmptyException();
      }
      logger.e(e);
      throw ServerException();
    }
  }

  Future<UserModel> _getUserByPhone(String phone) async {
    try {
      final result =
          await ApiUrl.patients.where("phone", isEqualTo: phone).get();
      final doc = result.docs.first;
      final user = UserModel.fromJson(doc.data(), doc.id);

      return user;
    } catch (e) {
      if (e.toString() == noElement) {
        throw EmptyException();
      }
      logger.e(e);
      throw ServerException();
    }
  }
}
