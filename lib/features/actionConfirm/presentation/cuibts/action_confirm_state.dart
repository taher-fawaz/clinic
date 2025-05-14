part of 'action_confirm_cubit.dart';

@immutable
sealed class ActionConfirmState {}

final class ActionConfirmInitial extends ActionConfirmState {}
final class ActionConfirmLoading extends ActionConfirmState {}

final class ActionConfirmSuccess extends ActionConfirmState {
  final bool isConfirmed;

  ActionConfirmSuccess(this.isConfirmed);
  List<Object> get props => [isConfirmed];
}

final class ActionConfirmFailure extends ActionConfirmState {
  final String message;

  ActionConfirmFailure({required this.message});
}