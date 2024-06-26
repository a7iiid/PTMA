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
    apiKey: 'AIzaSyADVgvZm0XHVbvBZtkZZa3F3P3COO5jTds',
    appId: '1:869932988389:web:4107890934b0094fe8e10c',
    messagingSenderId: '869932988389',
    projectId: 'ptma-9c13f',
    authDomain: 'ptma-9c13f.firebaseapp.com',
    storageBucket: 'ptma-9c13f.appspot.com',
    measurementId: 'G-N83L9WD6EP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2YCbbdy3OYHEQwa7JgL2mmW-tZFUfvpA',
    appId: '1:869932988389:android:2b6885a10ac2b328e8e10c',
    messagingSenderId: '869932988389',
    projectId: 'ptma-9c13f',
    storageBucket: 'ptma-9c13f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-2R3xlBGl_NRT4CQzmOUKf49uK4C6S78',
    appId: '1:869932988389:ios:169d97423f8c94ffe8e10c',
    messagingSenderId: '869932988389',
    projectId: 'ptma-9c13f',
    storageBucket: 'ptma-9c13f.appspot.com',
    androidClientId:
        '869932988389-unne8vkfmta5u39ub8b05q5jqli6fgcr.apps.googleusercontent.com',
    iosClientId:
        '869932988389-i4olqqrntk0913dtfoqch6rrvohevfsp.apps.googleusercontent.com',
    iosBundleId: 'com.example.ptma',
  );
}
