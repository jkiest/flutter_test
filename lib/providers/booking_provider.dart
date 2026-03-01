import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [];
  final bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Booking> get upcomingBookings => _bookings
        .where((b) =>
            b.status != BookingStatus.cancelled &&
            b.checkInDate.isAfter(DateTime.now()))
        .toList();

  List<Booking> get pastBookings => _bookings
        .where((b) =>
            b.status == BookingStatus.completed ||
            b.checkOutDate.isBefore(DateTime.now()))
        .toList();

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void cancelBooking(String bookingId) {
    final index =
        _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings[index] = Booking(
        id: _bookings[index].id,
        userId: _bookings[index].userId,
        hotelId: _bookings[index].hotelId,
        roomId: _bookings[index].roomId,
        checkInDate: _bookings[index].checkInDate,
        checkOutDate: _bookings[index].checkOutDate,
        numberOfGuests: _bookings[index].numberOfGuests,
        numberOfRooms: _bookings[index].numberOfRooms,
        totalPrice: _bookings[index].totalPrice,
        status: BookingStatus.cancelled,
        bookingDate: _bookings[index].bookingDate,
        specialRequests: _bookings[index].specialRequests,
      );
      notifyListeners();
    }
  }

  void updateBookingStatus(String bookingId, BookingStatus status) {
    final index =
        _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings[index] = Booking(
        id: _bookings[index].id,
        userId: _bookings[index].userId,
        hotelId: _bookings[index].hotelId,
        roomId: _bookings[index].roomId,
        checkInDate: _bookings[index].checkInDate,
        checkOutDate: _bookings[index].checkOutDate,
        numberOfGuests: _bookings[index].numberOfGuests,
        numberOfRooms: _bookings[index].numberOfRooms,
        totalPrice: _bookings[index].totalPrice,
        status: status,
        bookingDate: _bookings[index].bookingDate,
        specialRequests: _bookings[index].specialRequests,
      );
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
