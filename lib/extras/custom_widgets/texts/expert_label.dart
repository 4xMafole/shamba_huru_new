import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ExpertLabel extends StatelessWidget {
  const ExpertLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.verified,
      color: AppColor.paleBlue,
      size: 20,
    );
  }
}
