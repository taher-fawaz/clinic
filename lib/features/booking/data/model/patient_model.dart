class PatientModel {
  String id;
  String name;
  String address;
  String phone;
  String imageOne;
  String imageTwo;
  String imageThree;
  String age;
  DateTime dateDay;
  List<DateTime> dateTime;
  String note;

  PatientModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.imageOne,
    required this.imageTwo,
    required this.imageThree,
    required this.age,
    required this.dateDay,
    required this.dateTime,
    required this.note,
  });

  /// Convert PatientModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "imageOne": imageOne,
      "imageTwo": imageTwo,
      "imageThree": imageThree,
      "age": age,
      "dateDay": dateDay.toIso8601String(), // Convert DateTime to String
      "dateTime": dateTime
          .map((date) => date.toIso8601String())
          .toList(), // Convert List<DateTime> to List<String>
      "note": note,
    };
  }

  /// Convert JSON to PatientModel
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      imageOne: json["imageOne"],
      imageTwo: json["imageTwo"],
      imageThree: json["imageThree"],
      age: json["age"],
      dateDay: DateTime.parse(json["dateDay"]), // Convert String to DateTime
      dateTime: (json["dateTime"] as List<dynamic>)
          .map((date) =>
              DateTime.parse(date)) // Convert List<String> to List<DateTime>
          .toList(),
      note: json["note"],
    );
  }
}
