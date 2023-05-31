import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/controllers/auth_controller.dart';

import 'app/modules/loading/loading_view.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: Routes.ORDER_DETAIL,
          getPages: AppPages.routes,
        );

    // return StreamBuilder<User?>(
    //   stream: auth.authStateChanges(),
    //   builder: (context, snapAuth) {
    //     if (snapAuth.connectionState == ConnectionState.waiting) {
    //       return const LoadingView();
    //     }

    //     return GetMaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: "Application",
    //       initialRoute: snapAuth.hasData ? Routes.mainNavigation : Routes.signIn,
    //       getPages: AppPages.routes,
    //     );
    //   },
    // );
  }
}
