import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/failure_converter.dart';
import '../../../../../core/utils/logger.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/check_signin_status_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/patient_login_usecase.dart';
import '../../../domain/usecases/patient_register_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLogoutUseCase _logoutUseCase;
  final AuthCheckSignInStatusUseCase _checkSignInStatusUseCase;
  final PatientLoginUseCase _patientLoginUseCase;
  final PatientRegisterUseCase _patientRegisterUseCase;
  AuthBloc(
    this._logoutUseCase,
    this._checkSignInStatusUseCase,
    this._patientLoginUseCase,
    this._patientRegisterUseCase,
  ) : super(AuthInitialState()) {
    on<AuthLogoutEvent>(_logout);
    on<AuthCheckSignInStatusEvent>(_checkSignInStatus);
    on<PatientLoginEvent>(_patientLogin);
    on<PatientRegisterEvent>(_patientRegister);
  }

  Future _logout(AuthLogoutEvent event, Emitter emit) async {
    emit(AuthLogoutLoadingState());

    final result = await _logoutUseCase.call(NoParams());

    result.fold(
      (l) => emit(AuthLogoutFailureState(mapFailureToMessage(l))),
      (r) => emit(const AuthLogoutSuccessState("Logout Success")),
    );
  }

  Future _checkSignInStatus(
      AuthCheckSignInStatusEvent event, Emitter emit) async {
    emit(AuthCheckSignInStatusLoadingState());

    final result = await _checkSignInStatusUseCase.call(NoParams());

    result.fold(
      (l) => emit(AuthCheckSignInStatusFailureState(mapFailureToMessage(l))),
      (r) => emit(AuthCheckSignInStatusSuccessState(r)),
    );
  }

  Future _patientLogin(PatientLoginEvent event, Emitter emit) async {
    emit(PatientLoginLoadingState());

    final result = await _patientLoginUseCase.call(
      PatientLoginParams(
        phoneNumber: event.phoneNumber,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(PatientLoginFailureState(mapFailureToMessage(l))),
      (r) => emit(PatientLoginSuccessState(r)),
    );
  }

  Future _patientRegister(PatientRegisterEvent event, Emitter emit) async {
    emit(PatientRegisterLoadingState());

    final result = await _patientRegisterUseCase.call(
      PatientRegisterParams(
        name: event.name,
        phoneNumber: event.phoneNumber,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(PatientRegisterFailureState(mapFailureToMessage(l))),
      (r) => emit(
          const PatientRegisterSuccessState("Patient registration successful")),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthBloc =====");
    return super.close();
  }
}
