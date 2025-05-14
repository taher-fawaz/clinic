part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {
  final String uid;
  LoadUserProfile(this.uid);
}
