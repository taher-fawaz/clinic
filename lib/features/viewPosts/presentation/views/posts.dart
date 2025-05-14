import 'package:clinic/features/viewPosts/presentation/views/widgets/postsBlocConsumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/services/get_it_service.dart';
import '../../data/repo.dart';
import '../cubits/posts_cubit.dart';


class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (context) => PostsCubit(
      getIt.get<FirebasePostRepo>(),
    ),
    child:
    Scaffold(
      appBar: CustomBuildAppBar(context, title: "Posts", showBackButton: false,showNotification: false),
body: PostsBlocConsumer(),
    ));
  }
}
