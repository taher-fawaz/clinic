import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/appointment/domain/entities/appointment_entity.dart';
import 'package:clinic/features/appointment/domain/repos/appointment_repo.dart';
import 'package:clinic/features/admin/data/repositories/firebase_availability_repository.dart'; // To update slot status

// States
abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final String message;
  AppointmentSuccess(this.message);
}

class AppointmentFailure extends AppointmentState {
  final String message;
  AppointmentFailure(this.message);
}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentEntity> appointments;
  AppointmentsLoaded(this.appointments);
}

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;
  final FirebaseAvailabilityRepository
      availabilityRepository; // Injected to update slot status

  AppointmentCubit(this.appointmentRepo, this.availabilityRepository)
      : super(AppointmentInitial());

  Future<void> createAppointment(
      AppointmentEntity appointment, String availabilitySlotId) async {
    emit(AppointmentLoading());
    try {
      // First, attempt to book the slot
      await availabilityRepository.bookSlot(
          availabilitySlotId, appointment.patientId);

      // If slot booking is successful, create the appointment
      final result = await appointmentRepo.createAppointment(appointment);
      result.fold(
        (failure) async {
          // If appointment creation fails, try to unbook the slot to revert
          try {
            await availabilityRepository.unbookSlot(availabilitySlotId);
          } catch (e) {
            // Log or handle unbooking failure, though the primary error is appointment creation
            print(
                'Failed to unbook slot after appointment creation failure: $e');
          }
          emit(AppointmentFailure(
              'Failed to create appointment: ${failure.message}'));
        },
        (_) => emit(AppointmentSuccess('Appointment booked successfully!')),
      );
    } catch (e) {
      // This catch block handles errors from booking the slot itself
      emit(AppointmentFailure('Failed to book availability slot: $e'));
    }
  }

  Future<void> loadAppointments(String patientId) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.getAppointments(patientId);
    result.fold(
      (failure) => emit(AppointmentFailure(
          'Failed to load appointments: ${failure.message}')),
      (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }

  Future<void> cancelAppointment(String appointmentId, String patientId) async {
    emit(AppointmentLoading());
    final result = await appointmentRepo.cancelAppointment(appointmentId);
    result.fold(
      (failure) => emit(AppointmentFailure(
          'Failed to cancel appointment: ${failure.message}')),
      (_) {
        emit(AppointmentSuccess('Appointment cancelled successfully!'));
        loadAppointments(patientId); // Refresh the list
      },
    );
  }
}
