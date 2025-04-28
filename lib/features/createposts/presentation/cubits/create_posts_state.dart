part of 'create_posts_cubit.dart';

@immutable
sealed class CreatePostsState {}

final class CreatePostsInitial extends CreatePostsState {}

final class CreatePostsLoading extends CreatePostsState {}
final class CreatePostsSuccess extends CreatePostsState {}
final class CreatePostsFailure extends CreatePostsState {
  final String message;
  CreatePostsFailure({required this.message});
}

