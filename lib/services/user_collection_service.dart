// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelhive/models/property.dart';
import 'package:travelhive/models/user_model.dart';
import 'package:travelhive/models/wishlist_item.dart';

class UserCollectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkUserExists(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await _firestore.collection('users').doc(uid).get();
    return user.exists;
  }

  Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await _firestore.collection('users').doc(uid).get();
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

  Future<void> addBooking(
      {required String uid, required Property booking}) async {
    await _firestore.collection('users').doc(uid).update({
      'bookings': FieldValue.arrayUnion([booking.toMap()]),
    });
  }

  Future<void> updateUserPhoto(
      {required String uid, required String url}) async {
    await _firestore.collection('users').doc(uid).update({
      'photoUrl': url ?? '',
    });
  }

  Future<void> updateUserName(
      {required String uid, required String name}) async {
    await _firestore.collection('users').doc(uid).update({
      'name': name ?? '',
    });
  }

  Future<void> addWishlistItem(
      {required String uid, required WishlistItem item}) async {
    await _firestore.collection('users').doc(uid).update({
      'wishlist': FieldValue.arrayUnion([item.toMap()]),
    });
  }

  Future<void> removeWishlistItem(
      {required String uid, required WishlistItem item}) async {
    await _firestore.collection('users').doc(uid).update({
      'wishlist': FieldValue.arrayRemove([item.toMap()]),
    });
  }

  Future<void> addNotification(
      {required String uid, required String notification}) async {
    await _firestore.collection('users').doc(uid).update({
      'notifications': FieldValue.arrayUnion([notification]),
    });
  }
}
