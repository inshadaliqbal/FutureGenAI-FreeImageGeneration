import 'package:flutter/material.dart';
import 'package:futuregenai/style/constants.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  MainAppBar({required this.titleText});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Center(
        child: Text(
          titleText,
          style: kAppBarTextStyle,
        ),
      ),
    );
  }
}
