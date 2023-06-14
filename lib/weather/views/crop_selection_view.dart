import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:shamba_huru/weather/controllers/crop_selection_controller.dart';
import 'package:shamba_huru/content/views/content_view.dart';

import '../../extras/utils/app_colors.dart';

class CropSelectionView extends StatelessWidget {
  CropSelectionView({Key? key}) : super(key: key);

  final CropSelectionController _controller =
      Get.put(CropSelectionController());

  void _openFilterDialog(BuildContext context) async {
    await FilterListDialog.display<String>(
      context,
      hideSelectedTextCount: true,
      headlineText: 'Select Crops',
      themeData: FilterListThemeData(
        context,
        headerTheme: HeaderThemeData(
          searchFieldBackgroundColor: AppColor.paleGreen.withOpacity(0.1),
          searchFieldIconColor: AppColor.paleGreen,
          searchFieldTextStyle: TextStyle(
            color: AppColor.deepGreen,
          ),
          headerTextStyle: TextStyle(
            fontSize: 18,
            color: AppColor.deepGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        controlButtonBarTheme: ControlButtonBarThemeData(
          controlButtonTheme: ControlButtonThemeData(
            primaryButtonBackgroundColor: AppColor.paleGreen,
            textStyle: TextStyle(color: AppColor.paleGreen),
          ),
        ),
      ),
      hideCloseIcon: true,
      height: 500,
      listData: _controller.countList,
      selectedListData: _controller.selectedCountList,
      choiceChipLabel: (item) => item,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (text, query) {
        return text.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        _controller.selectedCountList.value = List.from(list!);
        Get.back();
      },
      choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected!
                ? AppColor.pullmanBrown
                : AppColor.pullmanBrown.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            item,
            style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColor.pullmanBrown.withOpacity(0.7)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.deepGreen,
        ),
        backgroundColor: AppColor.deepGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Crops",
        ),
        leading: IconButton(
          onPressed: (() => Get.back()),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: _verifyButton(context),
      body: GetX<CropSelectionController>(builder: (getContext) {
        _controller.selectedCountList
            .removeWhere((element) => element.contains("empty"));
        return Column(
          children: <Widget>[
            _controller.selectedCountList.isEmpty
                ? Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _openFilterDialog(context);
                        },
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/plant.png",
                                width: 60,
                                height: 60,
                              ),
                              Text(
                                'Add New Crops',
                                style: TextStyle(
                                  color: AppColor.paleGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GFListTile(
                          title: Text(_controller.selectedCountList[index]),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: _controller.selectedCountList.length,
                    ),
                  ),
          ],
        );
      }),
    );
  }

  Widget _verifyButton(BuildContext context) {
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
            _openFilterDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: Colors.white,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: () {
            //Edit
            Fluttertoast.showToast(
              msg: 'Crops added to the farm successfully!',
              backgroundColor: AppColor.deepGreen,
              textColor: Colors.white,
            );
          },
          child: Icon(
            Icons.done,
            color: AppColor.paleGreen,
          ),
        ),
      ],
    );
  }
}
