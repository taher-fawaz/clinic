import 'package:clinic/core/helper_functions/build_error_bar.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:clinic/core/widgets/custom_button.dart';
import 'package:clinic/core/widgets/custom_text_field.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:time_slot/controller/day_part_controller.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

class BookingViewBody extends StatefulWidget {
  const BookingViewBody({super.key});

  @override
  State<BookingViewBody> createState() => _BookingViewBodyState();
}

class _BookingViewBodyState extends State<BookingViewBody> {
  bool pending = true;
  List<DateTime> selectTime = [];
  DateTime selectedDate = DateTime.now();
  DayPartController dayPartController = DayPartController();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: dateWidget(),
            ),
            Card(child: timeWidget()),
            SizedBox(
              height: 20,
            ),
            Text(
              "ملاحظات",
              style: TextStyles.bold23,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: controller,
              hintText: "أكتب الشكوي ",
              textInputType: TextInputType.text,
              maxLines: 5,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              color:
                  pending ? AppColors.primaryColor : AppColors.secondaryColor,
              onPressed: () => _validateAndSubmit(),
              text: pending ? 'أحجز الأن' : "أنتظر الموافقه",
            ),
          ],
        ),
      ),
    );
  }

  Widget dateWidget() {
    return EasyDateTimeLine(
      locale: "ar",
      initialDate: DateTime.timestamp(),
      activeColor: AppColors.primaryColor,
      headerProps: EasyHeaderProps(
        monthStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.lightSecondaryColor),
      ),
      dayProps: EasyDayProps(
        todayStyle: DayStyle(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            dayNumStyle: TextStyles.semiBold13),
      ),
      onDateChange: (value) {
        print("Selected Date: $selectedDate");
        selectedDate = value;
      },
    );
  }

  Widget timeWidget() {
    return TimesSlotGridViewFromInterval(
      locale: "ar",
      initTime: selectTime,
      crossAxisCount: 4,
      timeSlotInterval: const TimeSlotInterval(
        start: TimeOfDay(hour: 10, minute: 00),
        end: TimeOfDay(hour: 22, minute: 0),
        interval: Duration(hours: 1, minutes: 0),
      ),
      onChange: (value) {
        setState(() {
          print(selectTime = value);
          selectTime = value;
        });
      },
    );
  }

  void _validateAndSubmit() {
    if (selectTime.isEmpty || controller.text.isEmpty) {
      showBar(context, 'من فضلك أكمل أدخال البيانات المناسب لك .');
    } else
      setState(() {
        pending = false;
      });
    print(controller.text);
    print(selectTime);
    print(selectedDate);
  }
}
