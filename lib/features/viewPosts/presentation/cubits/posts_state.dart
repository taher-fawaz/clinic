part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}
class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final List<String> posts;
  PostsSuccess(this.posts);
}

class PostsFailure extends PostsState {
  final String message;
   PostsFailure( this.message);

}