import 'package:flutter/material.dart';

import 'footer.dart';

class DefaultScreenContainer extends StatelessWidget {
  final List<Widget> children;

  const DefaultScreenContainer({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              constraints: const BoxConstraints(
                maxWidth: 930,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ... children,
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
