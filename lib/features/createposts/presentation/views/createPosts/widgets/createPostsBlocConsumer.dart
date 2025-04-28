import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../../core/widgets/custom_progress_hud.dart';
import '../../../cubits/create_posts_cubit.dart';
import 'createPostsBody.dart';

class CreatePostsBlocConsumer extends StatefulWidget {
  const CreatePostsBlocConsumer({super.key});

  @override
  State<CreatePostsBlocConsumer> createState() => _CreatePostsBlocConsumerState();
}

class _CreatePostsBlocConsumerState extends State<CreatePostsBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<CreatePostsCubit, CreatePostsState>(
      listener: (context, state) {
        if (state is CreatePostsSuccess) {
          showBar(context, "تم حفظ المنشور بنجاح");
        } else if (state is CreatePostsFailure) {
          showBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is CreatePostsLoading ? true : false,
          child: const CreatePostsBody(),
        );
      },
    );



  }
}
