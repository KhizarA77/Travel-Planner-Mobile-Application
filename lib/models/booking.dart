import 'package:travelhive/models/property.dart';

class Booking {

  final String bookingId;
  final Property property;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfGuests;

  Booking({
    required this.bookingId,
    required this.property,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfGuests,
  });

  factory Booking.fromMap(Map<String, dynamic> data) {

    return Booking(
      bookingId: data['bookingId'],
      property: Property.fromMap(data['property']),
      checkInDate: data['checkInDate'].toDate(),
      checkOutDate: data['checkOutDate'].toDate(),
      numberOfGuests: data['numberOfGuests'],
    );
  }

  Map<String, dynamic> toMap() {
    Map <String, dynamic> map = {
      'bookingId': bookingId,
      'property': property.toMap(),
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'numberOfGuests': numberOfGuests,
    };
    return map;
    
  }

}