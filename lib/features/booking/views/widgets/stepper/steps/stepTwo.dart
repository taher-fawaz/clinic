import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  String? _selectedValue;
  List<String> _items = ["مريض اخر", "انا المريض "];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          dropdown(),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            textInputType: TextInputType.text,
            hintText: "",
            border: false,
            label: "الاسم",
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            textInputType: TextInputType.text,
            hintText: "",
            border: false,
            label: "رقم التليقون ",
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            textInputType: TextInputType.text,
            hintText: "",
            border: false,
            label: "العنوان ",
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            textInputType: TextInputType.number,
            hintText: "",
            border: false,
            label: "رقم التليفون ",
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget dropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "من المريض ",
        // border: OutlineInputBorder(),
      ),
      value: _selectedValue,
      items: _items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
      validator: (value) => value == null ? "Please select an option" : null,
    );
  }
}
