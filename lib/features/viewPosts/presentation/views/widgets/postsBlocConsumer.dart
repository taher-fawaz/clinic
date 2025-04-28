import 'package:clinic/features/viewPosts/presentation/views/widgets/postsBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/posts_cubit.dart';

class PostsBlocConsumer extends StatefulWidget {
  const PostsBlocConsumer({super.key});

  @override
  State<PostsBlocConsumer> createState() => _PostsBlocConsumerState();
}

class _PostsBlocConsumerState extends State<PostsBlocConsumer> {
  @override
  void initState() {
    context.read<PostsCubit>().getPostsFromFirestore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostsSuccess) {
          return PostsBody(posts:state.posts);
        } else if (state is PostsFailure) {
          print("${state.message}");
          return Center(child: Text('Error${state.message} '));
        } else {
          return Center(child: Text('No posts available'));
        }
      },
    );


  }
}