import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';
import 'package:shamba_huru/profile/controllers/profile_controller.dart';

import 'package:shamba_huru/content/views/content_view.dart';

import '../../extras/services/firebase/database.dart';
import '../../extras/services/firebase/notification.dart';

class LoginController extends GetxController {
  FireDatabase database = FireDatabase();
  FireNotification notification = FireNotification();

  Future<void> googleUser(BuildContext context) async {
    User? user = await AuthController.authInstance.signInWithGoogle();

    if (user != null) {
      await database.userExists(user).then((value) {
        database.userToDatabase(user: user);
        notification.setUpNotification();
        Get.offAll(() => ContentView(user: user));
      });
    }
  }
}
