import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  String? _selectedValue;
  List<String> _items = ["Option 1", "Option 2", "Option 3", "Option 4"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dropdown(),
        SizedBox(
          height: 30,
        ),
        CustomTextFormField(
          textInputType: TextInputType.text,
          hintText: "v",
          border: false,
          label: "ggggggggg",
        ),
        SizedBox(
          height: 30,
        ),
        CustomTextFormField(
          textInputType: TextInputType.text,
          hintText: "v",
          border: false,
        ),
        SizedBox(
          height: 30,
        ),
        CustomTextFormField(
          textInputType: TextInputType.text,
          hintText: "v",
          border: false,
        ),
        SizedBox(
          height: 30,
        ),
        CustomTextFormField(
          textInputType: TextInputType.text,
          hintText: "v",
          border: false,
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget dropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Select an option",
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
