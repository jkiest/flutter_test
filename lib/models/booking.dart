import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  Booking({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfGuests,
    required this.numberOfRooms,
    required this.totalPrice,
    required this.status,
    required this.bookingDate,
    this.specialRequests,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  final String id;
  final String userId;
  final String hotelId;
  final String roomId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfGuests;
  final int numberOfRooms;
  final double totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;
  final String? specialRequests;

  Map<String, dynamic> toJson() => _$BookingToJson(this);

  int get numberOfDays => checkOutDate.difference(checkInDate).inDays;
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}
