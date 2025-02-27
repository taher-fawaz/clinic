import 'package:clinic/core/utils/app_images.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_text_styles.dart';

class ActionConfirm extends StatefulWidget {
  const ActionConfirm({super.key});

  @override
  State<ActionConfirm> createState() => _ActionConfirmState();
}

class _ActionConfirmState extends State<ActionConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              Assets.imagesWaiting,
              width: 400,
              height: 500,
              fit: BoxFit.cover,
            ),
            Text(
              "انتظر الموافقه ",
              style: TextStyles.bold28,
            )
          ],
        ),
      ),
    );
  }
}
