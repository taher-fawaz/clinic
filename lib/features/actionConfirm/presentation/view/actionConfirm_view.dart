import 'package:clinic/features/actionConfirm/presentation/view/widgets/ActionConfirmBlocConsumer.dart';
import 'package:clinic/features/actionConfirm/presentation/view/widgets/actionConfirmBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/get_it_service.dart';
import '../../data/repo.dart';
import '../cuibts/action_confirm_cubit.dart';
class ActionConfirm extends StatefulWidget {
  ActionConfirm({super.key});
  static const String routeName = "ActionConfirm";

  @override
  State<ActionConfirm> createState() => _ActionConfirmState();
}

class _ActionConfirmState extends State<ActionConfirm> {
  late final ActionConfirmCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = ActionConfirmCubit(getIt.get<FirebaseActionConfirmRepo>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getActionConfirm();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _cubit,
        child:  ActionConfirmBody(),
      ),
    );
  }
}