
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../cuibts/action_confirm_cubit.dart';
import 'ActionConfirmBlocConsumer.dart';

class ActionConfirmBody extends StatefulWidget {

   ActionConfirmBody({super.key});

  @override
  State<ActionConfirmBody> createState() => _ActionConfirmBodyState();
}

class _ActionConfirmBodyState extends State<ActionConfirmBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesWaiting,
            width: 400,
            height: 500,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            "انتظر الموافقة",
            style: TextStyles.bold28,
          ),
          const SizedBox(height: 20),
          ActionConfirmBlocConsumer(),
          // _buildStatusContainer(context),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              context.read<ActionConfirmCubit>().getActionConfirm();
            },
            text: "تحقق من الحالة",
          ),
        ],
      ),
    );
  }
}
