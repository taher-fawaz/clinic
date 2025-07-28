import 'package:equatable/equatable.dart';

class AvailableSlotModel extends Equatable {
  final String id;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final double price;
  final int durationMinutes;

  const AvailableSlotModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.price,
    required this.durationMinutes,
  });

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) {
    return AvailableSlotModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isAvailable: json['isAvailable'] as bool,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      price: (json['price'] as num).toDouble(),
      durationMinutes: json['durationMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'specialty': specialty,
      'price': price,
      'durationMinutes': durationMinutes,
    };
  }

  AvailableSlotModel copyWith({
    String? id,
    DateTime? date,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    String? doctorId,
    String? doctorName,
    String? specialty,
    double? price,
    int? durationMinutes,
  }) {
    return AvailableSlotModel(
      id: id ?? this.id,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        startTime,
        endTime,
        isAvailable,
        doctorId,
        doctorName,
        specialty,
        price,
        durationMinutes,
      ];

  String get timeRange => '$startTime - $endTime';
  
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';
}