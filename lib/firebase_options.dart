// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBNwY-wDcHGwnlP4Cjnd6wR00UkW7RVEQ8',
    appId: '1:667066355721:web:bfe404d7ba9dc8c86b28d8',
    messagingSenderId: '667066355721',
    projectId: 'scharoen-app',
    authDomain: 'scharoen-app.firebaseapp.com',
    databaseURL: 'https://scharoen-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scharoen-app.appspot.com',
    measurementId: 'G-J8KH94MEYF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBt07Ojnkpv8JJdgAFWFWo-5M9GQCID2dk',
    appId: '1:667066355721:android:f0da3a53395d517c6b28d8',
    messagingSenderId: '667066355721',
    projectId: 'scharoen-app',
    databaseURL: 'https://scharoen-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scharoen-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGSk-OWe5GMsKehPN6gVbitbFAy27aDbc',
    appId: '1:667066355721:ios:62475eda755132336b28d8',
    messagingSenderId: '667066355721',
    projectId: 'scharoen-app',
    databaseURL: 'https://scharoen-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scharoen-app.appspot.com',
    iosBundleId: 'mik.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGSk-OWe5GMsKehPN6gVbitbFAy27aDbc',
    appId: '1:667066355721:ios:366cf30e6e239f366b28d8',
    messagingSenderId: '667066355721',
    projectId: 'scharoen-app',
    databaseURL: 'https://scharoen-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'scharoen-app.appspot.com',
    iosBundleId: 'com.example.scharoenApp.RunnerTests',
  );
}
