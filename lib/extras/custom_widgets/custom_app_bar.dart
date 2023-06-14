import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const CustomAppBar(this.appBar, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) => Row(children: [
        const SizedBox(width: 16),
        Expanded(child: appBar),
        const SizedBox(width: 10),
      ]);
}
