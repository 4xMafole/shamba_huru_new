import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shamba_huru/content/views/content_view.dart';

import '../../extras/utils/app_colors.dart';
import '../controllers/add_feeds_controller.dart';

class AddMyFeedsView extends StatelessWidget {
  AddMyFeedsView({Key? key}) : super(key: key);

  final AddFeedController _controller = Get.put(AddFeedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Add New Feed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(
            () => ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 175,
                        height: 175,
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _controller.feedImage.isNotEmpty
                                ? FileImage(File(_controller.feedImage.value))
                                : Image.asset(
                                    //TODO: Change to a default image of a post
                                    "assets/images/farm.png",
                                  ).image,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              //TODO: Open the editor of photo
                              _controller.pickImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: AppColor.paleGreen,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )),
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
                        controller: _controller.titleController.value,
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(
                            color: AppColor.phthaloGreen.withOpacity(0.5),
                          ),
                        ),
                        formControlName: _controller.titleControl,
                      ),
                      ReactiveTextField(
                        controller: _controller.descController.value,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 500,
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: AppColor.phthaloGreen.withOpacity(0.5),
                          ),
                        ),
                        formControlName: _controller.descControl,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ReactiveFormConsumer(builder: (context, form, child) {
                        return InkWell(
                          onTap: form.valid
                              ? () {
                                  _controller.uploadPost();
                                }
                              : null,
                          child: Container(
                            width: 230,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.deepGreen,
                                  AppColor.paleGreen
                                ],
                              ),
                            ),
                            child: Text(
                              "Post",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
      ),
    );
  }
}
