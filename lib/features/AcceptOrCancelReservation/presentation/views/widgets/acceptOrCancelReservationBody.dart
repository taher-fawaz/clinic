import 'package:clinic/features/AcceptOrCancelReservation/presentation/views/widgets/showDialogConsumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/showDilog.dart';
import '../../../../booking/data/model/patient_model.dart';
import '../../cuibts/accept_or_cancel_reservation_cubit.dart';

class AcceptOrCancelReservationBody extends StatefulWidget {
  final List<PatientModel> patients;
  AcceptOrCancelReservationBody({super.key, required this.patients});

  @override
  State<AcceptOrCancelReservationBody> createState() => _AcceptOrCancelReservationBodyState();
}

class _AcceptOrCancelReservationBodyState extends State<AcceptOrCancelReservationBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: widget.patients.length,
        itemBuilder: (context, index) {
          return Card(
              child: GestureDetector(
                onTap: () {
                  showCustomDialog(
                    context,
                        () =>  BlocProvider.value(
                          value: context.read<AcceptOrCancelReservationCubit>(),
                          child: ShowDialogConsumer(userId: widget.patients[index].id,),
                        )
                  );
                },
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " المريض : ${widget.patients[index].selectPatient}",
                          style: TextStyles.bold16,),
                        Text("الاسم : ${widget.patients[index].name}",
                          style: TextStyles.bold16,),
                      ],),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" العمر : ${widget.patients[index].age}",
                          style: TextStyles.bold16,),
                        Text(
                          "   ${widget.patients[index].phone}  : رقم التليفون ",
                          style: TextStyles.bold16,),
                      ],),
                    Text("العنوان : ${widget.patients[index].address}",
                      style: TextStyles.bold16,),
                    Text(" الشكوي : ${widget.patients[index].note}",
                      style: TextStyles.bold16,),
                    // Text(" التاريخ : ${widget.patients[index].dateDay}",
                    //   style: TextStyles.bold16,),
                    Text(" الوقت : ${widget.patients[index].dateTime}",
                      style: TextStyles.bold16,),
                    Text(" التاريخ : ${DateFormat.yMd().format(widget.patients[index].dateDay)}",
                      style: TextStyles.bold16,),

                  ],),
              )
            // ListTile(
            //   title: Text(widget.patients[index].imageTwo.toString(),style: TextStyle(fontSize: 100),), // Example of displaying item
            // ),
          );
        },
      ),
    );
  }

}