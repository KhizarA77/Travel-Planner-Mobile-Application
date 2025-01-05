import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelhive/models/booking.dart';
import 'package:travelhive/models/user_model.dart';
import 'package:travelhive/models/wishlist_item.dart';


class UserCollectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<bool> checkUserExists(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user = await _firestore.collection('users').doc(uid).get();
    return user.exists;
  }

  Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user = await _firestore.collection('users').doc(uid).get();
    Map<String, dynamic> data = user.data()!;
    data['uid'] = uid;
    return UserModel.fromMap(data);
  }


  Future<void> addUserToCollection({required UserModel userModel}) async {
    await _firestore.collection('users').doc(userModel.uid).set({
      'name': userModel.name,
      'email': userModel.email,
      'photoUrl': userModel.photoUrl,
      'wishlist': [],
      'notifications': [],
      'bookings': [],
    });
  }

  Future<void> updateUserInCollection({required UserModel userModel}) async {
    await _firestore.collection('users').doc(userModel.uid).update({
      'name': userModel.name,
      'email': userModel.email,
      'photoUrl': userModel.photoUrl ?? '',
    });
  }

  Future<void> addWishlistItem({required String uid, required WishlistItem item}) async {
    await _firestore.collection('users').doc(uid).update({
      'wishlist': FieldValue.arrayUnion([item.toMap()]),
    });
  }

  Future<void> removeWishlistItem({required String uid, required WishlistItem item}) async {
    await _firestore.collection('users').doc(uid).update({
      'wishlist': FieldValue.arrayRemove([item.toMap()]),
    });
  }

  Future<void> addBooking({required String uid, required Booking booking}) async {
    await _firestore.collection('users').doc(uid).update({
      'bookings': FieldValue.arrayUnion([booking.toMap()]),
    });
  }


  Future<void> addNotification({required String uid, required String notification}) async {
    await _firestore.collection('users').doc(uid).update({
      'notifications': FieldValue.arrayUnion([notification]),
    });
  }

  
}