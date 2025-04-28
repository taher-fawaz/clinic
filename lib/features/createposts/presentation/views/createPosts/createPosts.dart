import 'package:clinic/features/createposts/presentation/views/createPosts/widgets/createPostsBlocConsumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../data/repos.dart';
import '../../cubits/create_posts_cubit.dart';


class CreatePosts extends StatefulWidget {
  const CreatePosts({super.key});

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreatePostsCubit(
          getIt.get<FirebasePostsRepo>(),
        ),
        child:
        Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomBuildAppBar(context, title: "Create Posts", showBackButton: false,showNotification: false),
            body:CreatePostsBlocConsumer()

        ));
  }

}


