import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/admin/data/repositories/firebase_appointment_repository.dart';
import 'dart:async';

// States
abstract class AdminAppointmentsState {}

class AdminAppointmentsInitial extends AdminAppointmentsState {}

class AdminAppointmentsLoading extends AdminAppointmentsState {}

class AdminAppointmentsLoaded extends AdminAppointmentsState {
  final List<AppointmentEntity> pendingAppointments;
  final List<AppointmentEntity> processedAppointments;

  AdminAppointmentsLoaded({
    required this.pendingAppointments,
    required this.processedAppointments,
  });
}

class AdminAppointmentsError extends AdminAppointmentsState {
  final String message;
  AdminAppointmentsError(this.message);
}

class AdminAppointmentsOperationSuccess extends AdminAppointmentsState {
  final String message;
  AdminAppointmentsOperationSuccess(this.message);
}

// Cubit
class AdminAppointmentsCubit extends Cubit<AdminAppointmentsState> {
  final FirebaseAppointmentRepository _repository;
  StreamSubscription<List<AppointmentEntity>>? _pendingAppointmentsSubscription;
  StreamSubscription<List<AppointmentEntity>>?
      _processedAppointmentsSubscription;

  List<AppointmentEntity> _pendingAppointments = [];
  List<AppointmentEntity> _processedAppointments = [];

  AdminAppointmentsCubit(this._repository) : super(AdminAppointmentsInitial());

  void loadAppointments() {
    emit(AdminAppointmentsLoading());

    // Cancel existing subscriptions
    _pendingAppointmentsSubscription?.cancel();
    _processedAppointmentsSubscription?.cancel();

    // Subscribe to pending appointments
    _pendingAppointmentsSubscription =
        _repository.getPendingAppointments().listen(
      (appointments) {
        _pendingAppointments = appointments;
        _emitLoadedState();
      },
      onError: (error) {
        emit(AdminAppointmentsError(
            'Failed to load pending appointments: $error'));
      },
    );

    // Subscribe to processed appointments
    _processedAppointmentsSubscription =
        _repository.getProcessedAppointments().listen(
      (appointments) {
        _processedAppointments = appointments;
        _emitLoadedState();
      },
      onError: (error) {
        emit(AdminAppointmentsError(
            'Failed to load processed appointments: $error'));
      },
    );
  }

  void _emitLoadedState() {
    emit(AdminAppointmentsLoaded(
      pendingAppointments: _pendingAppointments,
      processedAppointments: _processedAppointments,
    ));
  }

  Future<void> approveAppointment(String appointmentId) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, 'approved');
      emit(AdminAppointmentsOperationSuccess(
          'Appointment approved successfully'));
    } catch (e) {
      emit(AdminAppointmentsError('Failed to approve appointment: $e'));
    }
  }

  Future<void> rejectAppointment(String appointmentId) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, 'rejected');
      emit(AdminAppointmentsOperationSuccess(
          'Appointment rejected successfully'));
    } catch (e) {
      emit(AdminAppointmentsError('Failed to reject appointment: $e'));
    }
  }

  @override
  Future<void> close() {
    _pendingAppointmentsSubscription?.cancel();
    _processedAppointmentsSubscription?.cancel();
    return super.close();
  }
}
