import 'dart:io';

import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  File? _image;
  File? _imageOne;
  File? _imageTwo;
  File? _imageThree;

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
            // controller: controller,
            hintText: "أكتب الشكوي ",
            textInputType: TextInputType.text,
            maxLines: 5,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              imageWidget(_imageOne, 1),
              imageWidget(_imageTwo, 2),
              imageWidget(_imageThree, 3)
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> pickImage(int imageNumber) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _imageOne = File(pickedFile.path);
        } else if (imageNumber == 2) {
          _imageTwo = File(pickedFile.path);
        } else if (imageNumber == 3) {
          _imageThree = File(pickedFile.path);
        }
      });
    }
  }

  Widget imageWidget(File? image, int imageNumber) {
    return GestureDetector(
      onTap: () => pickImage(imageNumber),
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
