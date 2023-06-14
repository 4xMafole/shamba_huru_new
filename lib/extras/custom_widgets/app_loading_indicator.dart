import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color color;
  final double size;
  const AppLoadingIndicator({
    Key? key,
    required this.color,
    this.size = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: size,
      width: size,
      child: LoadingIndicator(
        indicatorType: Indicator.ballTrianglePathColoredFilled,
        colors: [color],
        strokeWidth: 2,
      ),
    ));
  }
}
