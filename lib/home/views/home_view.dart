import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/home/controllers/home_controller.dart';
import 'package:shamba_huru/home/views/market/market_view.dart';

import '../../extras/custom_widgets/cards/weather_card.dart';
import '../../extras/custom_widgets/crop_listview.dart';
import '../../extras/utils/app_colors.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.deepGreen,
        ),
        backgroundColor: AppColor.deepGreen,
        elevation: 0,
        title: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 14, top: 30, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: _controller.greeting(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                            text: ' User!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: AppColor.paleGrey,
                radius: 20,
                child: ClipOval(
                    child: Image.asset(
                  'assets/images/user.png',
                  fit: BoxFit.cover,
                  width: 55.0,
                  height: 55.0,
                )),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(() => Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // PromoCard(),
                  SizedBox(
                    height: 50,
                  ),
                  WeatherCard(
                    icon: _controller.weather.icon.value,
                    temp: _controller.weather.temp.value,
                    feeltemp: _controller.weather.feeltemp.value,
                    description: _controller.weather.description.value,
                    city: _controller.weather.city.value,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Market Prices",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.pullmanBrown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () => Get.to(() => MarketView()),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: AppColor.paleBrown.withOpacity(.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _controller.cropData.value.crops.isEmpty
                      ? Center(
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/price_chart.png",
                                  width: 60,
                                  height: 60,
                                ),
                                Text(
                                  'No recent market activities',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _marketPrices(context),
                ],
              ),
            )),
      ),
    );
  }

  _marketPrices(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 30,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CropListView(controller: _controller, cropIndex: index);
      },
    );
  }
}
