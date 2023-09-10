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
    apiKey: 'AIzaSyCw6ycl2gK_Bsq9n5REVZzKHRRJtgsT2NU',
    appId: '1:1004851603984:web:9cd582684cc6a3a90bb895',
    messagingSenderId: '1004851603984',
    projectId: 'tiktok-jw-v2',
    authDomain: 'tiktok-jw-v2.firebaseapp.com',
    storageBucket: 'tiktok-jw-v2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgtPOBd-B8aKTGlx1FHkhEjLmezBd_XXg',
    appId: '1:1004851603984:android:66dba6f9bcfa7eca0bb895',
    messagingSenderId: '1004851603984',
    projectId: 'tiktok-jw-v2',
    storageBucket: 'tiktok-jw-v2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQoHiOEfdVtWHkZcSS2NdIaLHTtbkE8Mc',
    appId: '1:1004851603984:ios:6bbe003a39c655bb0bb895',
    messagingSenderId: '1004851603984',
    projectId: 'tiktok-jw-v2',
    storageBucket: 'tiktok-jw-v2.appspot.com',
    iosBundleId: 'com.example.tiktokV2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQoHiOEfdVtWHkZcSS2NdIaLHTtbkE8Mc',
    appId: '1:1004851603984:ios:22fa6615fb7ef1120bb895',
    messagingSenderId: '1004851603984',
    projectId: 'tiktok-jw-v2',
    storageBucket: 'tiktok-jw-v2.appspot.com',
    iosBundleId: 'com.example.tiktokV2.RunnerTests',
  );
}
