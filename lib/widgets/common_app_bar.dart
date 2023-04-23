import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget? flexibleSpace;
  final double? elevation;
  const CommonAppBar(
      {super.key, required this.title, this.flexibleSpace, this.elevation = 1});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: elevation,
      flexibleSpace: flexibleSpace,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
