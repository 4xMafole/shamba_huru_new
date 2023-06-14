import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shamba_huru/options/views/edit_profile_controller.dart';
import 'package:shamba_huru/authentication/models/user.dart';

import '../../../../authentication/controllers/auth_controller.dart';
import '../../extras/utils/app_colors.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditProfileController _controller = Get.put(EditProfileController());

    return FutureBuilder<dynamic>(
        future: _controller.getProfileSnapshot(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return emptyWidget(context, _controller);
          } else {
            print("snapshot ${snapshot.data?.data()}");
            AppUser user = AppUser.fromDocument(snapshot.data);

            insertDefaultValues(_controller, user, snapshot.data.data());

            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppColor.deepGreen,
                ),
                backgroundColor: AppColor.deepGreen,
                elevation: 0,
                leading: IconButton(
                  onPressed: (() => Get.back()),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    user.photoUrl,
                                  ),
                                ),
                              ),
                            ),
                            // editProfilePhoto(context),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ReactiveForm(
                        formGroup: _controller.form,
                        child: Column(
                          children: <Widget>[
                            ReactiveTextField(
                              controller: _controller.nameController.value,
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(
                                  color: AppColor.phthaloGreen.withOpacity(0.5),
                                ),
                              ),
                              formControlName: _controller.nameControl,
                            ),
                            ReactiveTextField(
                              controller: _controller.workController.value,
                              decoration: InputDecoration(
                                labelText: "Field of Work",
                                labelStyle: TextStyle(
                                  color: AppColor.phthaloGreen.withOpacity(0.5),
                                ),
                              ),
                              formControlName: _controller.workControl,
                            ),
                            ReactiveTextField(
                              controller: _controller.locationController.value,
                              decoration: InputDecoration(
                                labelText: "Location",
                                labelStyle: TextStyle(
                                  color: AppColor.phthaloGreen.withOpacity(0.5),
                                ),
                              ),
                              formControlName: _controller.locationControl,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ReactiveFormConsumer(
                                builder: (context, form, child) {
                              return InkWell(
                                onTap: form.valid
                                    ? () {
                                        _controller.submitData();
                                      }
                                    : () => Get.snackbar(
                                          "Error",
                                          "Please! Fill all fields.",
                                          icon: Icon(
                                            Icons.text_fields_rounded,
                                            color: Colors.white,
                                          ),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: AppColor.red,
                                        ),
                                child: submitButton(),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  void insertDefaultValues(EditProfileController _controller, AppUser user,
      Map<String, dynamic> map) {
    _controller.form.patchValue({
      _controller.nameControl: user.username,
      _controller.workControl: user.bio,
      _controller.locationControl: map["location"] ?? "",
    });
    _controller.nameController.value.text = user.username;
    _controller.workController.value.text = user.bio;
    _controller.locationController.value.text = map["location"] ?? "";
  }

  Container submitButton() {
    return Container(
      width: 230,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [AppColor.deepGreen, AppColor.paleGreen],
        ),
      ),
      child: Text(
        "Submit",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Positioned editProfilePhoto(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 4,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            color: AppColor.paleGreen,
          ),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ));
  }

  Scaffold emptyWidget(
      BuildContext context, EditProfileController _controller) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.deepGreen,
        ),
        backgroundColor: AppColor.deepGreen,
        elevation: 0,
        leading: IconButton(
          onPressed: (() => Get.back()),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/user.png",
                          ),
                        ),
                      ),
                    ),
                    editProfilePhoto(context),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ReactiveForm(
                formGroup: _controller.form,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      controller: _controller.nameController.value,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(
                          color: AppColor.phthaloGreen.withOpacity(0.5),
                        ),
                      ),
                      formControlName: _controller.nameControl,
                    ),
                    ReactiveTextField(
                      controller: _controller.workController.value,
                      decoration: InputDecoration(
                        labelText: "Field of Work",
                        labelStyle: TextStyle(
                          color: AppColor.phthaloGreen.withOpacity(0.5),
                        ),
                      ),
                      formControlName: _controller.workControl,
                    ),
                    ReactiveTextField(
                      controller: _controller.locationController.value,
                      decoration: InputDecoration(
                        labelText: "Location",
                        labelStyle: TextStyle(
                          color: AppColor.phthaloGreen.withOpacity(0.5),
                        ),
                      ),
                      formControlName: _controller.locationControl,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReactiveFormConsumer(builder: (context, form, child) {
                      return submitButton();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
