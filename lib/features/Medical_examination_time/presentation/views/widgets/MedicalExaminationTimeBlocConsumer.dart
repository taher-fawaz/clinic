import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../../../actionConfirm/actionConfirm.dart';
import '../../cubits/medical_examination_time_cubit.dart';
import 'MedicalExaminationTimeBody.dart';

class MedicalExaminationTimeBlocConsumer extends StatefulWidget {
  const MedicalExaminationTimeBlocConsumer({super.key});

  @override
  State<MedicalExaminationTimeBlocConsumer> createState() => _MedicalExaminationTimeBlocConsumerState();
}

class _MedicalExaminationTimeBlocConsumerState extends State<MedicalExaminationTimeBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalExaminationTimeCubit, MedicalExaminationTimeState>(
      listener: (context, state){
        if (state is MedicalExaminationTimeSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActionConfirm()),
          );
        }
        if (state is MedicalExaminationTimeFailure) {
          showBar(context, state.message);
        }
      },
        builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is MedicalExaminationTimeLoading,
        child: MedicalExaminationTimeBody(),
      );
    },
    );
  }
}
