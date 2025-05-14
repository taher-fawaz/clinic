part of 'accept_or_cancel_reservation_cubit.dart';

@immutable
sealed class AcceptOrCancelReservationState {}

final class AcceptOrCancelReservationInitial extends AcceptOrCancelReservationState {}
final class AcceptOrCancelReservationLoading extends AcceptOrCancelReservationState {}

final class AcceptOrCancelReservationSuccess extends AcceptOrCancelReservationState {
  final List<PatientModel> patients;

  AcceptOrCancelReservationSuccess(this.patients);
}

final class AcceptOrCancelReservationFailure extends AcceptOrCancelReservationState {
  final String message;

  AcceptOrCancelReservationFailure({required this.message});
}
final class DeletedPatientLoading extends AcceptOrCancelReservationState {}
final class DeletedPatientSuccess extends AcceptOrCancelReservationState {}
final class DeletedPatientFailure extends AcceptOrCancelReservationState {
  final String message;

  DeletedPatientFailure(this.message);
}
