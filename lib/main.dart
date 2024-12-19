import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shopapp/controllers/category_controllers.dart';
import 'package:shopapp/controllers/firebase_options.dart';
import 'package:shopapp/vendor/views/auth/screens/main_vendor_screen.dart';
import 'package:shopapp/views/auth_screens/login_screen.dart';
import 'package:shopapp/views/nav_screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put<categoryController>(categoryController());
      }),
    );
  }
}
