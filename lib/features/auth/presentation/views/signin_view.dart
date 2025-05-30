import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/auth/domain/repos/auth_repo.dart';
import 'package:clinic/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBuildAppBar(context, title: 'تسجيل دخول'),
      body: const SigninViewBodyBlocConsumer(),
    );
  }
}
