import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/features/crop_detection/dashboard.dart';

import '../../utils/app_colors.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 155,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              LinearGradient(colors: [AppColor.paleGreen, AppColor.deepGreen])),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 120,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2Fillustrations%2Fillustration1.png?alt=media&token=901c672d-0f35-49ee-8543-1e27a0891a1c"))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Are your crops health?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Let's check farm's health \nless than minutes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                // Text(
                //   "How To?",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "Learn all in app features \nin less than minutes",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 16,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                _playButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _playButton() {
    return GestureDetector(
      onTap: () => Get.to(() => CropDashboard()),
      child: Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColor.deepGreen,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    spreadRadius: 5,
                  ),
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
