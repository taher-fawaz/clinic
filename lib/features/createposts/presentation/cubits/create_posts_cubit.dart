import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/repos.dart';

part 'create_posts_state.dart';

class CreatePostsCubit extends Cubit<CreatePostsState> {
  final FirebasePostsRepo firebasePostsRepo;
  CreatePostsCubit(this.firebasePostsRepo) : super(CreatePostsInitial());
  final TextEditingController postController = TextEditingController();
  List<String> posts = [];



  Future<void> createPosts(List<String> posts) async {
    emit(CreatePostsLoading());
    try {
      await firebasePostsRepo.savePostsToFirestore(posts);
      emit(CreatePostsSuccess());
    } catch (e) {
      debugPrint("CreatePosts Error: $e");
      emit(CreatePostsFailure(message: e.toString()));
    }
  }


  Future<void> savePosts() async {
    if (postController.text.trim().isNotEmpty) {
      posts.add(postController.text.trim());  // Add the text field input to posts
      postController.clear();
      await createPosts(posts);
    } else {
      emit(CreatePostsFailure(message: "No posts to save"));
    }
  }


}
