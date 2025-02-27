import 'package:clinic/features/booking/views/widgets/stepper/steps/stepTwo.dart';
import 'package:flutter/material.dart';

import 'steps/StepOne.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep < 2) {
          setState(() {
            _currentStep += 1;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
      onStepTapped: (step) {
        setState(() {
          _currentStep = step;
        });
      },
      steps: [
        Step(
          title: Text("Step 1"),
          content: StepOne(),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: Text("Step 2"),
          content: StepTwo(),
          isActive: _currentStep >= 1,
        ),
        Step(
          title: Text("Step 3"),
          content: Text("This is the final step"),
          isActive: _currentStep >= 2,
        ),
      ],
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: details.onStepContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Change button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 70, vertical: 12), // Padding
              ),
              child: Text(
                "Next",
                style: TextStyle(
                    color: Colors.white, fontSize: 16), // Text styling
              ),
            ),
            SizedBox(width: 10),
            OutlinedButton(
              onPressed: details.onStepCancel,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
              ),
              child: Text(
                "Back",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
