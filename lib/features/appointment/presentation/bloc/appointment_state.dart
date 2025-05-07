part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentEntity> appointments;

  const AppointmentsLoaded({required this.appointments});

  @override
  List<Object> get props => [appointments];
}

class AppointmentCreated extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentCreated({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class AppointmentUpdated extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentUpdated({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class AppointmentCancelled extends AppointmentState {}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
