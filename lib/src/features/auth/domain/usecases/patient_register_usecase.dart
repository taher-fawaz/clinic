import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class PatientRegisterUseCase implements UseCase<void, PatientRegisterParams> {
  final AuthRepository _authRepository;
  const PatientRegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(PatientRegisterParams params) async {
    if (params.name.isEmpty) {
      return Left(InvalidNameFailure());
    }

    if (params.phoneNumber.isEmpty) {
      return Left(InvalidPhoneNumberFailure());
    }

    if (params.password.isEmpty || params.password.length < 6) {
      return Left(InvalidPasswordFailure());
    }

    return await _authRepository.patientRegister(params);
  }
}

class PatientRegisterParams extends Equatable {
  final String name;
  final String phoneNumber;
  final String password;
  const PatientRegisterParams({
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        password,
      ];
}
