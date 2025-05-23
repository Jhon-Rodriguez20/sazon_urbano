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
    apiKey: 'AIzaSyCLDo-SlxQNMDGjidlKZLGysIJxKV0ySC4',
    appId: '1:949588837684:web:e7977ec1c7b7f436ea1161',
    messagingSenderId: '949588837684',
    projectId: 'sazonurbano-243a4',
    authDomain: 'sazonurbano-243a4.firebaseapp.com',
    storageBucket: 'sazonurbano-243a4.firebasestorage.app',
    measurementId: 'G-BJZGE6PH85',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTRh4nMKosLq61az960nkt5V9DCF3Y1so',
    appId: '1:949588837684:android:447bca1abd5bb749ea1161',
    messagingSenderId: '949588837684',
    projectId: 'sazonurbano-243a4',
    storageBucket: 'sazonurbano-243a4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgrIkCHEu3KEbvA73wsnzrkMXPtn2T9oI',
    appId: '1:949588837684:ios:2cc0c6848f4d0138ea1161',
    messagingSenderId: '949588837684',
    projectId: 'sazonurbano-243a4',
    storageBucket: 'sazonurbano-243a4.firebasestorage.app',
    iosBundleId: 'com.example.sazonUrbano',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgrIkCHEu3KEbvA73wsnzrkMXPtn2T9oI',
    appId: '1:949588837684:ios:2cc0c6848f4d0138ea1161',
    messagingSenderId: '949588837684',
    projectId: 'sazonurbano-243a4',
    storageBucket: 'sazonurbano-243a4.firebasestorage.app',
    iosBundleId: 'com.example.sazonUrbano',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLDo-SlxQNMDGjidlKZLGysIJxKV0ySC4',
    appId: '1:949588837684:web:834ed1059582a457ea1161',
    messagingSenderId: '949588837684',
    projectId: 'sazonurbano-243a4',
    authDomain: 'sazonurbano-243a4.firebaseapp.com',
    storageBucket: 'sazonurbano-243a4.firebasestorage.app',
    measurementId: 'G-P2C89BQVT0',
  );
}
