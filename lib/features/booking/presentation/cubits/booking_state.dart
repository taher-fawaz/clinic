part of 'booking_cubit.dart';

@immutable
sealed class BookingState {
  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingSuccess extends BookingState {}

final class BookingFailure extends BookingState {
  final String message;

  BookingFailure({required this.message});
}
final class GetTimeForTodayLoading extends BookingState {}
final  class GetTimeForTodaySuccess extends BookingState {
final List<DateTime> tasks;
@override
List<Object> get props => [tasks];
GetTimeForTodaySuccess(this.tasks);
}

final class GetTimeForTodayFailure extends BookingState {
  final String message;
  @override
  List<Object> get props => [message];
  GetTimeForTodayFailure({required this.message});}

final class BookingImagePicked extends BookingState {}

