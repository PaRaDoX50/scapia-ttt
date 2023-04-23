import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CommonTextButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16)),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: onPressed,
        child: const Text('Reset',
            style: TextStyle(color: Colors.white, fontSize: 20)));
  }
}
