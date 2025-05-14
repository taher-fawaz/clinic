import 'package:clinic/features/booking/presentation/views/stepper/steps/stepTwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../cubits/booking_cubit.dart';
import 'steps/StepOne.dart';
import 'steps/stepThree.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep == 1) {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          } else {
            return;
          }
        }

        if (_currentStep < 2) {
          setState(() {
            _currentStep += 1;
          });
          return;
        }

        context.read<BookingCubit>().booking();
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
          title: const Text("Step 1"),
          content:StepOne(),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: const Text("Step 2"),
          content: Form(
            key: _formKey,
            child: StepTwo(),
          ),
          isActive: _currentStep >= 1,
        ),
        Step(
          title: const Text("Step 3"),
          content: StepThree(),
          isActive: _currentStep >= 2,
        ),
      ],
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(onPressed:details.onStepContinue! ,text: "Next",width:160,),
            const SizedBox(width: 10),
            CustomButton(onPressed:details.onStepCancel! ,text: "Back",width:160,),
          ],
        );
      },
    );
  }
}