import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../extras/utils/app_colors.dart';
import '../../features/online_store/extras/home_grid_cards.dart';
import '../../features/online_store/grid_items.dart';

class FeatureView extends StatelessWidget {
  final int postIndex;
  final ScrollController? scrollController;
  FeatureView({Key? key, this.postIndex = 0, this.scrollController})
      : super(key: key);

  PageController pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> sliderList = [
    {
      "icon": 'images/banner1.png',
    },
    {
      "icon": 'images/banner2.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.deepGreen,
        elevation: 0,
        title: Text(
          "Features",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Free',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1,
                crossAxisCount: 4,
                children: List.generate(
                  freeIcons.length,
                  (index) => HomeGridCards(
                    gridItems: freeIcons[index],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Business',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1,
                crossAxisCount: 4,
                children: List.generate(
                  businessIcons.length,
                  (index) => HomeGridCards(
                    gridItems: businessIcons[index],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'What\'s New',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: 320,
              child: PageView.builder(
                pageSnapping: true,
                itemCount: sliderList.length,
                controller: pageController,
                onPageChanged: (int index) {},
                itemBuilder: (_, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        sliderList[index]['icon'],
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Enterprise',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1,
                crossAxisCount: 4,
                children: List.generate(
                  enterpriseIcons.length,
                  (index) => HomeGridCards(
                    gridItems: enterpriseIcons[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
