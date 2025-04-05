import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, Widget widgetShowDialog()) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero, // Makes the dialog fill the screen
        child: widgetShowDialog(),
      );
    },
  );
}
