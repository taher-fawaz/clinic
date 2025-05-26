import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  final String userId;

  const LoadHomeData({required this.userId});

  @override
  List<Object> get props => [userId];
}

class RefreshHomeData extends HomeEvent {
  final String userId;

  const RefreshHomeData({required this.userId});

  @override
  List<Object> get props => [userId];
}
