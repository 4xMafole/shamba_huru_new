import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class UsernameText extends StatelessWidget {
  const UsernameText({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColor.pullmanBrown,
      ),
    );
  }
}
