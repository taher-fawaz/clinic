import 'dart:io';
import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/booking_cubit.dart';


class StepThree extends StatefulWidget {

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            "ملاحظات",
            style: TextStyles.bold23,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
             controller: context.read<BookingCubit>().noteController ,
            hintText: "أكتب الشكوي ",
            textInputType: TextInputType.text,
            maxLines: 5,
          ),
          SizedBox(height: 20),
          BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              return Row(
                children: [
                  imageWidget(  context.read<BookingCubit>().imageOne, 1),
                  imageWidget(context.read<BookingCubit>().imageTwo, 2),
                  imageWidget(context.read<BookingCubit>().imageThree, 3)
                ],
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget imageWidget(File? image, int imageNumber) {
    return GestureDetector(
      onTap: () =>
        context.read<BookingCubit>().pickImage(imageNumber)
      ,
      child: Container(
        margin: EdgeInsets.all(8),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(image, fit: BoxFit.cover),
              )
            : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
      ),
    );
  }
}
