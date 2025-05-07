import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/appointment/domain/repos/appointment_repo.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo appointmentRepo;

  AppointmentBloc({required this.appointmentRepo})
      : super(AppointmentInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<CreateAppointment>(_onCreateAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onLoadAppointments(
      LoadAppointments event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.getAppointments(event.patientId);
    result.fold(
      (failure) => emit(AppointmentError(message: failure.message)),
      (appointments) => emit(AppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onCreateAppointment(
      CreateAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.createAppointment(event.appointment);
    result.fold(
      (failure) => emit(AppointmentError(message: failure.message)),
      (appointment) => add(LoadAppointments(patientId: appointment.patientId)),
    );
  }

  Future<void> _onUpdateAppointment(
      UpdateAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.updateAppointment(event.appointment);
    result.fold(
      (failure) => emit(AppointmentError(message: failure.message)),
      (appointment) => add(LoadAppointments(patientId: appointment.patientId)),
    );
  }

  Future<void> _onCancelAppointment(
      CancelAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.cancelAppointment(event.appointmentId);
    result.fold(
      (failure) => emit(AppointmentError(message: failure.message)),
      (_) => add(LoadAppointments(patientId: event.patientId)),
    );
  }
}
