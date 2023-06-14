import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../extras/custom_widgets/crop_listview.dart';
import '../../../extras/utils/app_colors.dart';
import '../../controllers/home_controller.dart';

class MarketView extends StatelessWidget {
  MarketView({Key? key}) : super(key: key);
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColor.deepGreen,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.deepGreen,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Market",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: _marketPrices(),
      ),
      //  RefreshIndicator(
      //   onRefresh: _controller.refreshList,
      //   child: buildFeed(),
    );
  }

  _marketPrices() {
    return Container(
      padding: EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: _controller.cropData.value.crops.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 30,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CropListView(
            controller: _controller,
            cropIndex: index,
          );
        },
      ),
    );
  }
}
