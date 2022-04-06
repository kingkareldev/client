import 'package:flutter/material.dart';

import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("USA"), value: "USA"),
    const DropdownMenuItem(child: Text("Canada"), value: "Canada"),
    const DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
    const DropdownMenuItem(child: Text("England"), value: "England"),
  ];
  return menuItems;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40, left: 15),
            child: Column(
              children: [
                Text(
                  localization.appName,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(localization.appHomeDescription),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
