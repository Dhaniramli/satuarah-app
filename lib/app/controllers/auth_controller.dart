import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // untuk cek kondisi ada auth atau tidak -> uid
  // NULL -> tidak ada user yang login
  //  uid -> ada user yang login
  String? uid;

  late FirebaseAuth auth;

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      if (event != null) {
        uid = event.uid;
      }
    });

    super.onInit();
  }
}
