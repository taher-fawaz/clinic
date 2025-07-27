import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/usecase_params.dart';
import '../usecases/patient_login_usecase.dart';
import '../usecases/patient_register_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> checkSignInStatus();

  // Patient-specific methods
  Future<Either<Failure, UserEntity>> patientLogin(PatientLoginParams params);
  Future<Either<Failure, void>> patientRegister(PatientRegisterParams params);
}
