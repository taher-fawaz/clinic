import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../cubits/medical_examination_time_cubit.dart';

class MedicalExaminationTimeBody extends StatefulWidget {
  MedicalExaminationTimeBody({super.key});

  @override
  State<MedicalExaminationTimeBody> createState() => _MedicalExaminationTimeBodyState();
}

class _MedicalExaminationTimeBodyState extends State<MedicalExaminationTimeBody> {

@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            children: [
              dateWidget(),
              timeWidget(),
              CustomButton(onPressed: () {
                context.read<MedicalExaminationTimeCubit>().saveTime(context);

                }
                , text: "Save Time",),
            ],
          ),
        )
        ;
  }
  Widget dateWidget() {
    return EasyDateTimeLine(
      locale: "ar",
      initialDate: DateTime.timestamp(),
      activeColor: AppColors.primaryColor,
      headerProps: EasyHeaderProps(
        monthStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.lightSecondaryColor),
      ),
      dayProps: EasyDayProps(
        todayStyle: DayStyle(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            dayNumStyle: TextStyles.semiBold13),
      ),
      onDateChange: (value) {
        print("Selected Date: $widget.selectedDate");
        context.read<MedicalExaminationTimeCubit>().selectedDate = value;
      },
    );
  }
  Widget timeWidget(){
    return   SizedBox(height:500,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(context.read<MedicalExaminationTimeCubit>().chooseTIME[index]
                  // widget.chooseTIME[index]
                  ?
              "اختر الوقت":"Time :${context.read<MedicalExaminationTimeCubit>().selectedTimes[index].format(context)

                } ",
                  style: TextStyle(fontSize: 18)),
              trailing: ElevatedButton(
                onPressed: () {
                  context.read<MedicalExaminationTimeCubit>().selectTime(context, index);
                  setState(() {});
                } ,
                child: Text("Pick Time"),
              ),
            ),
          );
        },
      ),
    );
  }
}
