import 'package:clinic/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../cubits/posts_cubit.dart';

class PostsBody extends StatefulWidget {
  List<String>posts;
   PostsBody({super.key,required this.posts});

  @override
  State<PostsBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostsBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:500 ,
          child: ListView.builder(
            itemCount: widget.posts.length,
            itemBuilder: (context, index) {
              return Card(
                child:   ListTile(title: Text(widget.posts[index],style: TextStyles.semiBold16 ,))
                ,
              );
            },
          ),
        ),
      ],
    );
  }
}
