import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../cuibts/action_confirm_cubit.dart';

class ActionConfirmBlocConsumer extends StatefulWidget {
  const ActionConfirmBlocConsumer({super.key});

  @override
  State<ActionConfirmBlocConsumer> createState() => _ActionConfirmBlocConsumerState();
}

class _ActionConfirmBlocConsumerState extends State<ActionConfirmBlocConsumer> {
  @override
  void initState() {
    context.read<ActionConfirmCubit>().getActionConfirm();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActionConfirmCubit, ActionConfirmState>(
      listener: (context, state) {
        if (state is ActionConfirmFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ActionConfirmInitial || state is ActionConfirmLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ActionConfirmSuccess) {
          return Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:   state.isConfirmed ? Colors.green : Colors.orange,
            ),
            child: Center(
              child: Text(
                state.isConfirmed  ? 'تمت الموافقة' : 'في انتظار الموافقة',
                style: TextStyles.bold28,
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}