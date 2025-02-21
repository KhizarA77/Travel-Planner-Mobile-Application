// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnmOdDq1phQ3QdzNvJW1U3EepuE8JdeAE',
    appId: '1:406780517648:android:3fd1db84fc7665aa91d995',
    messagingSenderId: '406780517648',
    projectId: 'travelhive-df14a',
    storageBucket: 'travelhive-df14a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbm2Xh8sOqVu1fXdzUZfMEVRNwaM1eTM8',
    appId: '1:406780517648:ios:2a4316998c716d5891d995',
    messagingSenderId: '406780517648',
    projectId: 'travelhive-df14a',
    storageBucket: 'travelhive-df14a.firebasestorage.app',
    androidClientId: '406780517648-jlg3crs7q48ul479966lbie92qa31sle.apps.googleusercontent.com',
    iosClientId: '406780517648-0800ali5fs67lk58e744epveg65bf19k.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelhive',
  );
}
