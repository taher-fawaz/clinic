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
  String dateTime;
  String note;
  String selectPatient;

  PatientModel({
    required this.selectPatient,
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
      "selectPatient":selectPatient,
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "imageOne": imageOne,
      "imageTwo": imageTwo,
      "imageThree": imageThree,
      "age": age,
      "dateDay": dateDay.toIso8601String(), // Convert DateTime to String
      "dateTime": dateTime,

      "note": note,
    };
  }

  /// Convert JSON to PatientModel
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      selectPatient:json["selectPatient"],
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      imageOne: json["imageOne"],
      imageTwo: json["imageTwo"],
      imageThree: json["imageThree"],
      age: json["age"],
      dateDay: DateTime.parse(json["dateDay"]), // Convert String to DateTime
      dateTime: json["dateTime"] ,
      note: json["note"],
    );
  }
}
