class UserModel {

  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<dynamic> wishlist;
  final List<dynamic> notifications;
  final List<dynamic> bookings;

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

    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      wishlist: data['wishlist'],
      notifications: data['notifications'],
      bookings: data['bookings'],
    );
  }


}