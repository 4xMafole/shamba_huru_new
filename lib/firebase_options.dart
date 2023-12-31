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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBSIDCfGwSbGl31cHJQ1s1qkRYnqZvsmdk',
    appId: '1:1058645063759:web:f237b5af19b21a78a9523a',
    messagingSenderId: '1058645063759',
    projectId: 'shamba-huru',
    authDomain: 'shamba-huru.firebaseapp.com',
    storageBucket: 'shamba-huru.appspot.com',
    measurementId: 'G-0121QNKN1Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAJkosb98_3JjQo7VzlzUyhyZv1lclwy0',
    appId: '1:1058645063759:android:9db6d3398ec23751a9523a',
    messagingSenderId: '1058645063759',
    projectId: 'shamba-huru',
    storageBucket: 'shamba-huru.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP-ngVxR4KpuHhSFGAb88R0qIWpZRRvZE',
    appId: '1:1058645063759:ios:5adef149495a2a38a9523a',
    messagingSenderId: '1058645063759',
    projectId: 'shamba-huru',
    storageBucket: 'shamba-huru.appspot.com',
    iosClientId: '1058645063759-0gdquaafs0e88ok8vaps5a0bd0ajtiu6.apps.googleusercontent.com',
    iosBundleId: 'com.example.shambaHuru',
  );
}
