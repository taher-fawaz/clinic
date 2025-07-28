import 'package:equatable/equatable.dart';

class BookAppointmentResponseModel extends Equatable {
  final String appointmentId;
  final String status; // 'confirmed', 'pending', 'cancelled'
  final String message;
  final DateTime bookedAt;
  final AppointmentDetailsModel appointmentDetails;
  final PaymentInfoModel? paymentInfo;
  final bool requiresPayment;
  final String? confirmationCode;

  const BookAppointmentResponseModel({
    required this.appointmentId,
    required this.status,
    required this.message,
    required this.bookedAt,
    required this.appointmentDetails,
    this.paymentInfo,
    this.requiresPayment = false,
    this.confirmationCode,
  });

  factory BookAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentResponseModel(
      appointmentId: json['appointmentId'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      bookedAt: DateTime.parse(json['bookedAt'] as String),
      appointmentDetails: AppointmentDetailsModel.fromJson(
          json['appointmentDetails'] as Map<String, dynamic>),
      paymentInfo: json['paymentInfo'] != null
          ? PaymentInfoModel.fromJson(
              json['paymentInfo'] as Map<String, dynamic>)
          : null,
      requiresPayment: json['requiresPayment'] as bool? ?? false,
      confirmationCode: json['confirmationCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'status': status,
      'message': message,
      'bookedAt': bookedAt.toIso8601String(),
      'appointmentDetails': appointmentDetails.toJson(),
      'paymentInfo': paymentInfo?.toJson(),
      'requiresPayment': requiresPayment,
      'confirmationCode': confirmationCode,
    };
  }

  BookAppointmentResponseModel copyWith({
    String? appointmentId,
    String? status,
    String? message,
    DateTime? bookedAt,
    AppointmentDetailsModel? appointmentDetails,
    PaymentInfoModel? paymentInfo,
    bool? requiresPayment,
    String? confirmationCode,
  }) {
    return BookAppointmentResponseModel(
      appointmentId: appointmentId ?? this.appointmentId,
      status: status ?? this.status,
      message: message ?? this.message,
      bookedAt: bookedAt ?? this.bookedAt,
      appointmentDetails: appointmentDetails ?? this.appointmentDetails,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      requiresPayment: requiresPayment ?? this.requiresPayment,
      confirmationCode: confirmationCode ?? this.confirmationCode,
    );
  }

  @override
  List<Object?> get props => [
        appointmentId,
        status,
        message,
        bookedAt,
        appointmentDetails,
        paymentInfo,
        requiresPayment,
        confirmationCode,
      ];

  bool get isConfirmed => status == 'confirmed';
  bool get isPending => status == 'pending';
  bool get isCancelled => status == 'cancelled';
}

class AppointmentDetailsModel extends Equatable {
  final String slotId;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final double price;
  final String appointmentType;
  final String? notes;

  const AppointmentDetailsModel({
    required this.slotId,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.appointmentType,
    this.notes,
  });

  factory AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsModel(
      slotId: json['slotId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      price: (json['price'] as num).toDouble(),
      appointmentType: json['appointmentType'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'specialty': specialty,
      'appointmentDate': appointmentDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'appointmentType': appointmentType,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        slotId,
        doctorId,
        doctorName,
        specialty,
        appointmentDate,
        startTime,
        endTime,
        price,
        appointmentType,
        notes,
      ];

  String get timeRange => '$startTime - $endTime';
  String get formattedPrice => '${price.toStringAsFixed(0)} ر.س';
}

class PaymentInfoModel extends Equatable {
  final String paymentId;
  final double amount;
  final String currency;
  final String paymentMethod;
  final String paymentStatus;
  final String? paymentUrl;
  final DateTime? paymentDeadline;

  const PaymentInfoModel({
    required this.paymentId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentUrl,
    this.paymentDeadline,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      paymentId: json['paymentId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentUrl: json['paymentUrl'] as String?,
      paymentDeadline: json['paymentDeadline'] != null
          ? DateTime.parse(json['paymentDeadline'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentUrl': paymentUrl,
      'paymentDeadline': paymentDeadline?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        paymentId,
        amount,
        currency,
        paymentMethod,
        paymentStatus,
        paymentUrl,
        paymentDeadline,
      ];

  String get formattedAmount => '${amount.toStringAsFixed(2)} $currency';
}