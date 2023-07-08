import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/controllers/auth_controller.dart';
import 'package:satuarah/shared/splashscreen_view.dart';

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

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: "Application",
    //       initialRoute: Routes.MAKE_A_TRIP,
    //       getPages: AppPages.routes,
    //     );

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapAuth) {
        if (snapAuth.hasError) {
          return const Center(
            child: Text("Terjadi Kesalahan"),
          );
        }
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Get.testMode = true;
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Application",
                initialRoute:
                    snapAuth.hasData ? Routes.mainNavigation : Routes.signIn,
                getPages: AppPages.routes,
              );
            }
            return const SplachscreenView();
          },
        );
      },
    );
  }
}
