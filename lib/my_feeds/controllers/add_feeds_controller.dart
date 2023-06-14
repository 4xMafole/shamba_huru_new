import 'dart:io';

// import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';
import 'package:shamba_huru/my_feeds/models/post.dart';

import '../../extras/services/firebase/database.dart';
import '../../extras/services/firebase/storage.dart';
import '../../extras/services/geo/location.dart';

class AddFeedController extends GetxController {
  final String titleControl = "title";
  final String descControl = "description";
  final CustomLocation location = Get.put(CustomLocation());
  final FireDatabase database = FireDatabase();
  final FireStorage storage = FireStorage();

  final Rx<TextEditingController> titleController = TextEditingController().obs;
  final Rx<TextEditingController> descController = TextEditingController().obs;
  final RxString feedImage = "".obs;
  final ImagePicker imagePicker = ImagePicker();
  final RxBool isUploading = false.obs;
  late FormGroup form;

  @override
  void onInit() {
    super.onInit();
    titleController.value.text = "";
    descController.value.text = "";
    form = FormGroup({
      titleControl: FormControl<String>(validators: [Validators.required]),
      descControl: FormControl<String>(validators: [Validators.required]),
    });
  }

  void resetForm() {
    form.reset();
    titleController.value.text = "";
    descController.value.text = "";
  }

  Future<void> pickImage() async {
    XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    feedImage.value = imageFile!.path;
  }

  Future<void> uploadPost() async {
    isUploading.value = true;
    await storage
        .uploadImage(
          ownerId: AuthController.authInstance.firebaseUser.value!.uid,
          imagePath: feedImage.value,
        )
        .then((url) => database
                .setPostData(
              mediaUrl: url,
              city: location.city.value,
              description: descController.value.text.trim(),
            )
                .then((_) {
              resetForm();
              isUploading.value = false;
              feedImage.value = "";
              Get.back();
            }));
  }
}
