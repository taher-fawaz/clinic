import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/booking_cubit.dart';


class StepTwo extends StatefulWidget {

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {

  List<String> _items = ["مريض اخر", "انا المريض "];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          dropdown(),
          SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.text,
            controller:context.read<BookingCubit>().nameController,
            hintText: "",
            border: false,
            label: "الاسم",

          ),
          SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.text,
            controller: context.read<BookingCubit>().ageController,
            hintText: "",
            border: false,
            label: "العمر ",
          ),
          SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.text,
            controller: context.read<BookingCubit>().addressController,
            hintText: "",
            border: false,
            label: "العنوان ",
          ),
          SizedBox(height: 30),
          CustomTextFormField(
            textInputType: TextInputType.number,
            controller: context.read<BookingCubit>().phoneController,
            hintText: "",
            border: false,
            label: "رقم التليفون ",
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget dropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "من المريض ",
      ),
      value:  context.read<BookingCubit>().selectedValue,
      items: _items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          context.read<BookingCubit>().selectedValue  = newValue;
        });
      },
    );
  }
}