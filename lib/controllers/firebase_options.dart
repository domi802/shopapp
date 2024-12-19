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
    apiKey: 'AIzaSyCJv8fhM7qT5_muWyWnIocEjBZfudjQZvY',
    appId: '1:679523544145:web:e0ab10b3a857a5ff699c70',
    messagingSenderId: '679523544145',
    projectId: 'shopstore-2e8c8',
    authDomain: 'shopstore-2e8c8.firebaseapp.com',
    storageBucket: 'shopstore-2e8c8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKMtLkWV8NnZfSdcmXJfo21uEn58krFkw',
    appId: '1:679523544145:android:0d6235a43de213d4699c70',
    messagingSenderId: '679523544145',
    projectId: 'shopstore-2e8c8',
    storageBucket: 'shopstore-2e8c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJmmS5wSH06XmvGoFEcaIUhrJI1GeIdxw',
    appId: '1:679523544145:ios:007f83eb4c0b0181699c70',
    messagingSenderId: '679523544145',
    projectId: 'shopstore-2e8c8',
    storageBucket: 'shopstore-2e8c8.appspot.com',
    iosBundleId: 'com.example.shopapp',
  );
}
