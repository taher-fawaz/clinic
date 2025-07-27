part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthRegisterEvent(
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
  );

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        confirmPassword,
      ];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckSignInStatusEvent extends AuthEvent {}

class PatientLoginEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  const PatientLoginEvent(this.phoneNumber, this.password);

  @override
  List<Object?> get props => [phoneNumber, password];
}

class PatientRegisterEvent extends AuthEvent {
  final String name;
  final String phoneNumber;
  final String password;

  const PatientRegisterEvent(
    this.name,
    this.phoneNumber,
    this.password,
  );

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        password,
      ];
}
