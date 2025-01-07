import 'package:travelhive/models/property.dart';

class UserModel {

  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<Property?> wishlist;
  final List<String?> notifications;
  final List<Property?> bookings;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.wishlist,
    required this.notifications,
    required this.bookings,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    List<dynamic> wishlist = data['wishlist'] as List<dynamic>;
    List<dynamic> bookings = data['bookings'] as List<dynamic>;
    List<dynamic> notifications = data['notifications'] as List<dynamic>;

    List<Property> wishlistList = wishlist.isNotEmpty 
      ? wishlist.map((property) => Property.fromMap(property)).toList() 
      : [];
    List<String> notificationsList = notifications.isNotEmpty 
      ? notifications.map((notification) => notification as String).toList() 
      : [];
    List<Property> bookingsList  = bookings.isNotEmpty 
      ? bookings.map((booking) {
        booking['propertyId'] = "zzz";
        return Property.fromMap(booking);
      }).toList() 
      : [];

    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      wishlist: wishlistList,
      notifications: notificationsList,
      bookings: bookingsList,
    );
  }


}