
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper_functions/build_error_bar.dart';
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
          ActionConfirmBlocConsumer(),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              deletePastDays(context);
              // context.read<ActionConfirmCubit>().getActionConfirm();
            },
            text: "تحقق من الحالة",
          ),
        ],
      ),
    );
  }


  Future<void> deletePastDays(BuildContext context) async {
    try {
      DateTime now = DateTime.now();
      String todayFormatted = "${now.year}-${now.month}-${now.day}";

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tasksByDate')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String docId = doc.id;

        if (docId.compareTo(todayFormatted) < 0) {
          await FirebaseFirestore.instance.collection('tasksByDate').doc(docId).delete();
        }
      }

      showBar(context, "تم حذف جميع الأيام الماضية بنجاح");
    } catch (e) {
      showBar(context, "حدث خطأ أثناء الحذف: ${e.toString()}");
    }
  }
}
