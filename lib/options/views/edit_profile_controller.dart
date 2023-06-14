import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../authentication/controllers/auth_controller.dart';
import '../../extras/services/firebase/database.dart';

class EditProfileController extends GetxController {
  FireDatabase database = FireDatabase();
  var currentUserId = AuthController.authInstance.firebaseUser.value?.uid.obs;
  var currentUser = AuthController.authInstance.firebaseUser.value;

  final String nameControl = "username";
  final String workControl = "work";
  final String locationControl = "location";
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> workController = TextEditingController().obs;
  final Rx<TextEditingController> locationController =
      TextEditingController().obs;
  late FormGroup form;

  @override
  void onInit() {
    super.onInit();
    nameController.value.text = "";
    workController.value.text = "";
    locationController.value.text = "";
    form = FormGroup({
      nameControl: FormControl<String>(validators: [Validators.required]),
      workControl: FormControl<String>(validators: [Validators.required]),
      locationControl: FormControl<String>(validators: [Validators.required]),
    });
  }

  void resetForm() {
    form.reset();
    nameController.value.text = "";
    workController.value.text = "";
    locationController.value.text = "";
  }

  Future getProfileSnapshot() async {
    if (currentUser != null) {
      return database.getProfile(currentUser!.uid);
    }
  }

  Future<void> submitData() async {
    await updateUser().then((value) {
      resetForm();
      Get.back();
    });

    Get.back();
  }

  Future<void> updateUser() async {
    Map<String, Object?> data = {};
    data.addAll({
      "username": nameController.value.text.trim(),
      "bio": workController.value.text.trim(),
      "location": locationController.value.text.trim(),
    });
    await database.userUpdate(currentUserId: currentUserId!.value, data: data);
  }
}
