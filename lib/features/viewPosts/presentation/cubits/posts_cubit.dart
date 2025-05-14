import 'package:bloc/bloc.dart';
import 'package:clinic/features/viewPosts/data/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'posts_state.dart';


class PostsCubit extends Cubit<PostsState> {
  final FirebasePostRepo firebasePostRepo;

  PostsCubit(this.firebasePostRepo) : super(PostsInitial());


  Future<void> getPostsFromFirestore() async {
    try {
      emit(PostsLoading()); // Emit loading state
      List<String> posts = await firebasePostRepo.getPostsFromFirestore();
      emit(PostsSuccess(posts));
    } catch (e) {
  emit(PostsFailure( e.toString()));
    }
  }

}