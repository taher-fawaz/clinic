import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../cubits/create_posts_cubit.dart';


class CreatePostsBody extends StatefulWidget {
  const CreatePostsBody({super.key});

  @override
  State<CreatePostsBody> createState() => _CreatePostsBodyState();
}

class _CreatePostsBodyState extends State<CreatePostsBody> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      reverse: true,
      child: Card(
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("اكتب المنشور", style: TextStyles.bold23),

                    CustomTextFormField(
                      controller: context.read<CreatePostsCubit>().postController,
                      hintText: "المنشورات",
                      textInputType: TextInputType.text,
                      maxLines: 10,
                    ),
                    SizedBox(height: 100),
                    CustomButton(
                      onPressed: (){
                         context.read<CreatePostsCubit>().savePosts();
                      },

                      text: "نشر الكل",
                    ),
                    SizedBox(height: 300),

                  ],
                ),
)
         );
  }


}
