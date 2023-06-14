import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shamba_huru/home/controllers/market/market_stat_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extras/custom_widgets/crop_stat_listview.dart';
import '../../../extras/utils/app_colors.dart';
import '../../controllers/home_controller.dart';

class MarketStatsView extends StatelessWidget {
  List pageData;
  MarketStatsView({Key? key, required this.pageData}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());
  final MarketStatController _statsController = Get.put(MarketStatController());

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
          pageData[0],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => _header()),
            SizedBox(
              height: 20,
            ),
            _stats(),
            SizedBox(
              height: 20,
            ),
            _marketPrices(),
          ],
        ),
      ),
    );
  }

  _marketPrices() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: 15,
          left: 15,
        ),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: _statsController
              .getCropData(_controller.cropData.value.crops, pageData)
              .length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 30,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CropStatListView(
              date: _statsController.dateTimeFirestore(
                  DateTime.parse(_statsController.newCropList[index][0])),
              price: _statsController
                  .priceFormatter(_statsController.newCropList[index][1]),
              percentage: _statsController.pricePercentage(
                lastPrice: _statsController.newCropList[index][1],
                initPrice: _statsController.newCropList[index][1] ==
                        _statsController.newCropList[
                            _statsController.newCropList.length - 1][1]
                    ? 0.0
                    : _statsController.newCropList[index + 1][1],
              ),
            );
          },
        ),
      ),
    );
  }

  _stats() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.auto,
        axisLine: AxisLine(
          width: 0,
          color: Colors.transparent,
        ),
        majorGridLines: MajorGridLines(width: 0),
        rangePadding: ChartRangePadding.normal,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelPosition: ChartDataLabelPosition.inside,
        tickPosition: TickPosition.inside,
        majorTickLines:
            MajorTickLines(size: 6, width: 2, color: Color(0xFFFFFFFF)),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(
          color: AppColor.paleBrown,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines:
            MajorTickLines(size: 6, width: 2, color: Color(0xFFFFFFFF)),
        axisLine: AxisLine(
          width: 0,
          color: Colors.transparent,
        ),
        numberFormat: NumberFormat.compact(),
        // labelPosition: ChartDataLabelPosition.inside,
        tickPosition: TickPosition.inside,
      ),
      tooltipBehavior: _statsController.tooltipBehavior,
      series: <ChartSeries>[
        SplineAreaSeries<PriceData, DateTime>(
          xAxisName: "Months",
          yAxisName: "Prices",
          dataLabelSettings: DataLabelSettings(showZeroValue: false),
          dataSource: _statsController.chartData,
          splineType: SplineType.cardinal,
          color: AppColor.pullmanBrown.withOpacity(.7),
          cardinalSplineTension: 0.9,
          enableTooltip: true,
          sortingOrder: SortingOrder.ascending,
          sortFieldValueMapper: (PriceData data, _) => data.month,
          xValueMapper: (PriceData data, _) => data.month,
          yValueMapper: (PriceData data, _) => data.prices,
        )
      ],
    );
  }

  _header() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Price(Tshs)",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.paleBrown,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            _statsController.priceFormatter(_statsController.newCropList.isEmpty
                ? 00.0
                : _statsController.newCropList.first[1]),
            style: TextStyle(
              fontSize: 24,
              color: AppColor.pullmanBrown,
            ),
          ),
        ],
      ),
    );
  }
}
