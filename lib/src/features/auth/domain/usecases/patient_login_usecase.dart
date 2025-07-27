import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class PatientLoginUseCase implements UseCase<UserEntity, PatientLoginParams> {
  final AuthRepository _authRepository;
  const PatientLoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(PatientLoginParams params) async {
    if (params.phoneNumber.isEmpty) {
      return Left(InvalidPhoneNumberFailure());
    }

    if (params.password.isEmpty || params.password.length < 6) {
      return Left(InvalidPasswordFailure());
    }

    final result = await _authRepository.patientLogin(params);

    return result;
  }
}

class PatientLoginParams extends Equatable {
  final String phoneNumber;
  final String password;
  const PatientLoginParams({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
      ];
}
