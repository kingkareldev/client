import 'package:flutter/material.dart';

import '../components/menu.dart';
import 'app_frame.dart';

class AppWindow extends StatelessWidget {
  final Widget child;

  const AppWindow({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppFrame(),
          Expanded(
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) {
                    return Column(
                      children: [
                        const Menu(),
                        Expanded(
                          child: child,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
