abstract class BookingRepo {
  Future<void> addBooking(
      {required String name,
      required String address,
      required String phone,
      required String imageOne,
      required String imageTwo,
      required String imageThree,
      required String age,
      required DateTime dateDay,
      required String dateTime,
      required String note}) ;
    // TODO: implement addBooking
  Future<List<DateTime>> getTimeForToday(context,DateTime dateNow);
}
