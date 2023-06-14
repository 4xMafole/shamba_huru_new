import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shamba_huru/options/controllers/my_farm_controller.dart';

import '../../extras/custom_widgets/texts/text_01.dart';
import '../../extras/utils/app_colors.dart';
import '../../weather/views/map_farm_view.dart';

class MyFarmView extends StatelessWidget {
  MyFarmView({Key? key}) : super(key: key);
  final MyFarmController _controller = Get.put(MyFarmController());
  @override
  Widget build(BuildContext context) {
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
          "My Farm",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: _addButton(context),
      body: _controller.farmData.value.farmDetails.isEmpty
          ? GestureDetector(
              onTap: () {
                _controller.clearValues();
                _editBottomModal(
                    widget: _editFarmDetails(
                  context,
                  isNew: true,
                ));
              },
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/farm_2.png",
                        width: 60,
                        height: 60,
                        color: AppColor.paleGreen,
                      ),
                      Text(
                        'Add New Farm',
                        style: TextStyle(
                          color: AppColor.paleGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _controller.farmData.value.farmDetails.length,
              itemBuilder: ((context, index) {
                return _farmContent(
                  context: context,
                  farmIndex: index,
                );
              }),
            ),
    );
  }

  Widget _farmContent({required BuildContext context, required int farmIndex}) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.updateValues(
                      _controller.farmData.value.farmDetails[farmIndex].name,
                      _controller.farmData.value.farmDetails[farmIndex].crop,
                      _controller.farmData.value.farmDetails[farmIndex].area,
                    );
                    _editBottomModal(widget: _editFarmDetails(context));
                  },
                  child: _farmPhoto(
                    imageUrl:
                        _controller.farmData.value.farmDetails[farmIndex].photo,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                _farmDetails(
                  name: _controller.farmData.value.farmDetails[farmIndex].name,
                  crop: _controller.farmData.value.farmDetails[farmIndex].crop,
                  area: _controller.farmData.value.farmDetails[farmIndex].area,
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _farmPhoto({required String imageUrl}) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _farmDetails(
      {required String area, required String crop, required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _details(
          title: "Farm Name",
          name: name,
        ),
        _details(
          title: "Crop",
          name: crop,
        ),
        _details(
          title: "Area",
          name: area,
        ),
      ],
    );
  }

  Widget _details({required String title, required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text01(
          text: title,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.pullmanBrown,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _editBottomModal({required Widget widget}) => Get.bottomSheet(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Center(
                child: Divider(
                  indent: 190,
                  endIndent: 190,
                  height: 10,
                  thickness: 4,
                ),
              ),
              widget,
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  Widget _editFarmDetails(BuildContext context, {bool isNew = false}) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ReactiveForm(
              formGroup: _controller.form,
              child: Column(
                children: <Widget>[
                  if (isNew) ...[
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: (() => Get.to(() => MapFarmView())),
                        child: CircleAvatar(
                          backgroundColor: AppColor.paleGrey,
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/farm.png'),
                        ),
                      ),
                    ),
                  ],
                  ReactiveTextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Farm Name",
                      labelStyle: TextStyle(
                        color: AppColor.phthaloGreen.withOpacity(0.5),
                      ),
                    ),
                    formControlName: _controller.nameControl,
                  ),
                  ReactiveTextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Crop",
                      labelStyle: TextStyle(
                        color: AppColor.phthaloGreen.withOpacity(0.5),
                      ),
                    ),
                    formControlName: _controller.cropControl,
                  ),
                  ReactiveTextField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Area Size",
                      labelStyle: TextStyle(
                        color: AppColor.phthaloGreen.withOpacity(0.5),
                      ),
                    ),
                    formControlName: _controller.areaControl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ReactiveFormConsumer(builder: (context, form, child) {
                    return Row(
                      children: [
                        if (!isNew) ...[
                          //! Delete Button
                          InkWell(
                            onTap: form.valid
                                ? () {
                                    //TODO: Delete details
                                    Get.back();
                                  }
                                : null,
                            child: Container(
                              width: 100,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.shade900,
                                    Colors.red,
                                  ],
                                ),
                              ),
                              child: Text(
                                "Delete",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                        Expanded(child: Container()),

                        //! Save Button
                        InkWell(
                          onTap: form.valid
                              ? () {
                                  //TODO: update/save details
                                  Get.back();
                                }
                              : null,
                          child: Container(
                            width: 100,
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
                              "Save",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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
    );
  }

  Widget _addButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: AppColor.paleGreen,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: () {
            //Edit
            _controller.clearValues();
            _editBottomModal(
                widget: _editFarmDetails(
              context,
              isNew: true,
            ));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
