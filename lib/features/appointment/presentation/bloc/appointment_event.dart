part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  final String patientId;

  const LoadAppointments({required this.patientId});

  @override
  List<Object> get props => [patientId];
}

class CreateAppointment extends AppointmentEvent {
  final AppointmentEntity appointment;

  const CreateAppointment({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class UpdateAppointment extends AppointmentEvent {
  final AppointmentEntity appointment;

  const UpdateAppointment({required this.appointment});

  @override
  List<Object> get props => [appointment];
}

class CancelAppointment extends AppointmentEvent {
  final String appointmentId;
  final String patientId;

  const CancelAppointment(
      {required this.appointmentId, required this.patientId});

  @override
  List<Object> get props => [appointmentId, patientId];
}
