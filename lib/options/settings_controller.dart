import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../content/views/content_view.dart';

class SettingsController extends GetxController {
  Future<void> logout(BuildContext context) async {
    await AuthController.authInstance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Phoenix.rebirth(context);
    Get.offAll(() => ContentView());
  }
}
