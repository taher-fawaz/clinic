import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../data/repos/repo.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {


  final FirebaseBookingRepo firebaseBookingRepo;
   TextEditingController nameController;
   TextEditingController ageController;
   TextEditingController addressController;
   TextEditingController phoneController;
   TextEditingController noteController;
  String? selectedValue;
  DateTime selectedDate;
  DateTime  selectedTime;
  String formattedHour;
  File? imageOne;
  File? imageTwo;
  File? imageThree;
  BookingCubit(this.firebaseBookingRepo)
      : nameController = TextEditingController(),
        ageController = TextEditingController(),
        addressController = TextEditingController(),
        phoneController = TextEditingController(),
        noteController = TextEditingController(),
        selectedDate = DateTime.now(),
        selectedTime = DateTime.now(),
        formattedHour = DateFormat.Hm().format(DateTime.now()),
        super(BookingInitial());


  Future<void> booking() async {
    emit(BookingLoading());
    String  formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    var result = await firebaseBookingRepo.addBooking(
      selectPatient:selectedValue??"",
      name: nameController.text,
      address: addressController.text,
      phone: phoneController.text,
      imageOne: "imageOne",
      imageTwo: "imageTwo",
      imageThree: "imageThree",
      dateDay:selectedDate ,
      dateTime: formattedHour,
      age: ageController.text,
      note: noteController.text,
    );
    result.fold(
      (failure) => emit(BookingFailure(message: failure.message)),
      (patient) => emit(BookingSuccess()),
    );
  }

  void fetchTodayTasks( context, DateTime dateNow) async {
    emit(GetTimeForTodayLoading());
    try {
      List<DateTime> loadedTasks = await firebaseBookingRepo.getTimeForToday(context,dateNow);
      emit(GetTimeForTodaySuccess(loadedTasks));
    } catch (e) {
      emit(GetTimeForTodayFailure( message: e.toString()));

    }
  }

  Future<void> pickImage(int imageNumber) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        if (imageNumber == 1) {
          imageOne = File(pickedFile.path);
        } else if (imageNumber == 2) {
          imageTwo = File(pickedFile.path);
        } else if (imageNumber == 3) {
          imageThree = File(pickedFile.path);
        }
        emit(BookingImagePicked());

    }
  }


}
