import 'package:flutter/material.dart';


void showCustomDialog(BuildContext context, Widget widgetShowDialog()) {
  showDialog(
    context: context,
    builder: (BuildContext context)
  {
    return widgetShowDialog();
  });
}