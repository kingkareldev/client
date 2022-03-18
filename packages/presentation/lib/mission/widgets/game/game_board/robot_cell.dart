import 'package:flutter/material.dart';

class RobotCell extends StatelessWidget {
  const RobotCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("🤴", style: TextStyle(fontSize: 32)),
    );
  }
}
