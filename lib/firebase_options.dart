// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCHMu3WBVuZMethonpq476CppkdjZmS7uA',
    appId: '1:974716091349:web:671fa8a1e3952e7a169b5c',
    messagingSenderId: '974716091349',
    projectId: 'posrem-db',
    authDomain: 'posrem-db.firebaseapp.com',
    storageBucket: 'posrem-db.firebasestorage.app',
    measurementId: 'G-X8J2MCFDSW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEZ0tE42f8pEHHIex88g-E87eq_Qgb4cc',
    appId: '1:974716091349:android:aab99b41796275a8169b5c',
    messagingSenderId: '974716091349',
    projectId: 'posrem-db',
    storageBucket: 'posrem-db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD1BsMn-3AS1xAJkRQjKzIoetkyvwevT8',
    appId: '1:974716091349:ios:4467f02d36e5d1f4169b5c',
    messagingSenderId: '974716091349',
    projectId: 'posrem-db',
    storageBucket: 'posrem-db.firebasestorage.app',
    iosBundleId: 'com.example.posremProfileapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD1BsMn-3AS1xAJkRQjKzIoetkyvwevT8',
    appId: '1:974716091349:ios:4467f02d36e5d1f4169b5c',
    messagingSenderId: '974716091349',
    projectId: 'posrem-db',
    storageBucket: 'posrem-db.firebasestorage.app',
    iosBundleId: 'com.example.posremProfileapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHMu3WBVuZMethonpq476CppkdjZmS7uA',
    appId: '1:974716091349:web:0189a76686a2d7bc169b5c',
    messagingSenderId: '974716091349',
    projectId: 'posrem-db',
    authDomain: 'posrem-db.firebaseapp.com',
    storageBucket: 'posrem-db.firebasestorage.app',
    measurementId: 'G-FYNPDVDEMP',
  );
}
