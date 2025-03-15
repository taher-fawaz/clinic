import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../cubits/booking_cubit.dart';
import 'StepOne.dart';

class GetTimeWidget extends StatefulWidget {
  DateTime dateNow =DateTime.now();
  final Function(String) onTimeSelected;
  GetTimeWidget({super.key, required this.onTimeSelected});

  @override
  State<GetTimeWidget> createState() => _GetTimeWidgetState();
}

class _GetTimeWidgetState extends State<GetTimeWidget> {
  int? selectedIndex;
  @override
  void initState() {

    context.read<BookingCubit>().fetchTodayTasks(context,widget.dateNow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is GetTimeForTodayLoading) {

          return Center(child: CircularProgressIndicator()); // Show loading
        }
        if (state is GetTimeForTodayFailure) {
          return Center(child: Text(state.message,
              style: TextStyle(color: Colors.red))); // Show error message
        }
        if (state is GetTimeForTodaySuccess) {
          print("📅 Retrieved Tasks: ${state.tasks}");
          return
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (state.tasks.length / 3).ceil(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (index * 3 < state.tasks.length)
                        buildTaskCard(state.tasks[index * 3], index * 3), // 1st row
                      if (index * 3 + 1 < state.tasks.length)
                        buildTaskCard(state.tasks[index * 3 + 1], index * 3 + 1,), // 2nd row
                      if (index * 3 + 2 < state.tasks.length)
                        buildTaskCard(state.tasks[index * 3 + 2], index * 3 + 2,),// 3r
                    ],
                  );
                },
              ),
            );
        }
        return SizedBox();
      },
    );

  }
  Widget buildTaskCard(DateTime dateTime,int index,) {
    String formattedHour = DateFormat.Hm().format(dateTime);
    return GestureDetector(
      onTap: (){setState(() {
        selectedIndex = index;
      });
      widget.onTimeSelected(formattedHour);

      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          color: selectedIndex == index ?  AppColors.primaryColor : AppColors.white,

          child: Center(
            child: Text(
              formattedHour,
              style: TextStyle(fontSize: 20 , color: selectedIndex == index ?  AppColors.white :AppColors.black, ),
            ),
          ),
        ),
      ),
    );
  }


}
