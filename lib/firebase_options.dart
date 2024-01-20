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
    apiKey: 'AIzaSyAR5GU1cJjA6uRkDZIRw0J0hTSIiIjgjM8',
    appId: '1:152066747996:web:f759ae0d1d2e10b3130099',
    messagingSenderId: '152066747996',
    projectId: 'expense-tracker-c8e90',
    authDomain: 'expense-tracker-c8e90.firebaseapp.com',
    storageBucket: 'expense-tracker-c8e90.appspot.com',
    measurementId: 'G-CMX2N0ZW06',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCy2mVOMMXj7cQyxdxEpJ6AReQEK04TKr0',
    appId: '1:152066747996:android:3a8b2923646a1e65130099',
    messagingSenderId: '152066747996',
    projectId: 'expense-tracker-c8e90',
    storageBucket: 'expense-tracker-c8e90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKcwYkKZlmgqsCQI9SXCOAeFC0Hh1kbi4',
    appId: '1:152066747996:ios:115be2289f06c17e130099',
    messagingSenderId: '152066747996',
    projectId: 'expense-tracker-c8e90',
    storageBucket: 'expense-tracker-c8e90.appspot.com',
    iosBundleId: 'com.example.blocship',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKcwYkKZlmgqsCQI9SXCOAeFC0Hh1kbi4',
    appId: '1:152066747996:ios:7b131b6348a210c5130099',
    messagingSenderId: '152066747996',
    projectId: 'expense-tracker-c8e90',
    storageBucket: 'expense-tracker-c8e90.appspot.com',
    iosBundleId: 'com.example.blocship.RunnerTests',
  );
}
