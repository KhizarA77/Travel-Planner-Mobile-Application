// auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelhive/models/user_model.dart';
import 'package:travelhive/services/user_collection_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserRegisterModel {
  final String email;
  final String displayName;

  UserRegisterModel({required this.email, required this.displayName});
}

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserCollectionService _userCollectionService = UserCollectionService();

  Future<String> registerWithEmailPassword({required UserRegisterModel user, required String password}) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email, 
      password: password,
    );
    await userCredential.user!.sendEmailVerification();
    await userCredential.user!.updateDisplayName(user.displayName);
    String uid = userCredential.user!.uid;
    Map<String, dynamic> userMap = {
      'uid': uid,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': '',
      'wishlist': [],
      'notifications': [],
      'bookings': [],
    };
    UserModel userModel = UserModel.fromMap(userMap);
    await _userCollectionService.addUserToCollection(userModel: userModel);
    return 'Verification email sent';

    
  } on FirebaseAuthException catch (e) {
    return e.message ?? 'An error occurred';
  } catch (e) {
    return e.toString();
  }
}


  Future<String> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'A password reset link has been sent to your email';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured';
    } on Exception catch (e) {
      return e.toString();
    }
  }


  Future<String> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser!.emailVerified) {
        return 'Success';
      } else {
        userCredential.user!.sendEmailVerification();
        return 'Email not verified, please verify your email before proceeding';
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      String uid = userCredential.user!.uid;
      bool userExists = await _userCollectionService.checkUserExists(uid);
      if (!userExists) {
        Map<String, dynamic> userMap = {
          'uid': uid,
          'name': userCredential.user!.displayName ?? '',
          'email': userCredential.user!.email ?? '',
          'photoUrl': userCredential.user!.photoURL ?? '',
          'wishlist': [],
          'notifications': [],
        };
        UserModel userModel = UserModel.fromMap(userMap);
        await _userCollectionService.addUserToCollection(userModel: userModel);
      }
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown error occurred';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> continueWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status != LoginStatus.success) {
        throw Exception('Facebook login failed');
      }
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      String uid = userCredential.user!.uid;
      bool userExists = await _userCollectionService.checkUserExists(uid);
      if (!userExists) {
        Map<String, dynamic> userMap = {
          'uid': uid,
          'name': userCredential.user!.displayName ?? '',
          'email': userCredential.user!.email ?? '',
          'photoUrl': userCredential.user!.photoURL ?? '',
          'wishlist': [],
          'notifications': [],
        };
        UserModel userModel = UserModel.fromMap(userMap);
        await _userCollectionService.addUserToCollection(userModel: userModel);
      }
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown error occurred';
    } on Exception catch (e) {
      return e.toString();
    }
  }


}
