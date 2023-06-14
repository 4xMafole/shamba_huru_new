import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:like_button/like_button.dart';

import '../../extras/custom_widgets/cards/post_card.dart';
import '../../extras/utils/app_colors.dart';
import '../controllers/feeds_controller.dart';

class MainFeedView extends StatelessWidget {
  MainFeedView({Key? key}) : super(key: key);

  final FeedsController _controller = Get.put(FeedsController());

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
        title: Text(
          "Feeds",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: _controller.refreshList,
        child: buildFeed(),
      ),
    );
  }

  buildFeed() => _controller.feedData.isEmpty
      ? emptyWidget()
      : Obx(
          () => InfiniteListView(
            physics: const BouncingScrollPhysics(),
            itemCount: _controller.feedData.length,
            itemBuilder: ((context, index) {
              return PostCard(
                postIndex: index,
                controller: _controller,
              );
            }),
            nextData: _controller.loadNextData,
            hasNext: _controller.feedData.length > 200,
          ),
        );

  Center emptyWidget() {
    return Center(
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/news_feed.png",
              width: 60,
              height: 60,
              color: Colors.grey,
            ),
            Text(
              'No recent feeds',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
