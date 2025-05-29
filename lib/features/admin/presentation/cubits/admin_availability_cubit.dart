import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/admin/data/models/availability_slot_model.dart';
import 'package:clinic/features/admin/data/repositories/firebase_availability_repository.dart';
import 'dart:async';

// States
abstract class AdminAvailabilityState {}

class AdminAvailabilityInitial extends AdminAvailabilityState {}

class AdminAvailabilityLoading extends AdminAvailabilityState {}

class AdminAvailabilityLoaded extends AdminAvailabilityState {
  final List<AvailabilitySlotModel> slots;
  AdminAvailabilityLoaded(this.slots);
}

class AdminAvailabilityError extends AdminAvailabilityState {
  final String message;
  AdminAvailabilityError(this.message);
}

class AdminAvailabilityOperationSuccess extends AdminAvailabilityState {
  final String message;
  AdminAvailabilityOperationSuccess(this.message);
}

// Cubit
class AdminAvailabilityCubit extends Cubit<AdminAvailabilityState> {
  final FirebaseAvailabilityRepository _repository;
  StreamSubscription<List<AvailabilitySlotModel>>? _slotsSubscription;

  AdminAvailabilityCubit(this._repository) : super(AdminAvailabilityInitial());

  void loadAvailabilitySlots() {
    emit(AdminAvailabilityLoading());
    _slotsSubscription?.cancel();
    _slotsSubscription = _repository.getAvailabilitySlots().listen(
      (slots) {
        // Sort slots by day of week and then start time for consistent display
        slots.sort((a, b) {
          int dayCompare = _dayOfWeekToSortOrder(a.dayOfWeek)
              .compareTo(_dayOfWeekToSortOrder(b.dayOfWeek));
          if (dayCompare != 0) return dayCompare;
          return a.startTime.compareTo(b.startTime);
        });
        emit(AdminAvailabilityLoaded(slots));
      },
      onError: (error) {
        emit(AdminAvailabilityError(
            'Failed to load availability slots: $error'));
      },
    );
  }

  Future<void> addAvailabilitySlot(AvailabilitySlotModel slot) async {
    try {
      emit(AdminAvailabilityLoading());
      await _repository.addAvailabilitySlot(slot);
      emit(AdminAvailabilityOperationSuccess(
          'Availability slot added successfully'));
      loadAvailabilitySlots(); // Refresh list
    } catch (e) {
      emit(AdminAvailabilityError('Failed to add availability slot: $e'));
    }
  }

  Future<void> updateAvailabilitySlot(
      String slotId, AvailabilitySlotModel slot) async {
    try {
      emit(AdminAvailabilityLoading());
      await _repository.updateAvailabilitySlot(slotId, slot);
      emit(AdminAvailabilityOperationSuccess(
          'Availability slot updated successfully'));
      loadAvailabilitySlots(); // Refresh list
    } catch (e) {
      emit(AdminAvailabilityError('Failed to update availability slot: $e'));
    }
  }

  Future<void> deleteAvailabilitySlot(String slotId) async {
    try {
      emit(AdminAvailabilityLoading());
      await _repository.deleteAvailabilitySlot(slotId);
      emit(AdminAvailabilityOperationSuccess(
          'Availability slot deleted successfully'));
      loadAvailabilitySlots(); // Refresh list
    } catch (e) {
      emit(AdminAvailabilityError('Failed to delete availability slot: $e'));
    }
  }

  int _dayOfWeekToSortOrder(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return 1;
      case 'tuesday':
        return 2;
      case 'wednesday':
        return 3;
      case 'thursday':
        return 4;
      case 'friday':
        return 5;
      case 'saturday':
        return 6;
      case 'sunday':
        return 7;
      default:
        return 8; // Should not happen
    }
  }

  @override
  Future<void> close() {
    _slotsSubscription?.cancel();
    return super.close();
  }
}
