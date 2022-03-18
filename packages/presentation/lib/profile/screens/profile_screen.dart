import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../../model/user.dart';
import '../../router/blocs/router/router_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

User user = User(
  username: 'tenhobi',
  realName: 'Honza Bittner',
  email: 'mail@tenhobi.dev',
  description: 'Student at FIT CTU',
);

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.greenAccent.shade100, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(user.realName),
                        Text(user.email),
                        const SizedBox(height: 50),
                        Text(user.description),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                OutlinedButton(
                  onPressed: () => routerBloc.add(ToSettingsRoute()),
                  child: Text(localization.profileSettingsButton),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
