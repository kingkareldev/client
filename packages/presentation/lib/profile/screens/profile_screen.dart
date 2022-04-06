import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/blocs/authentication/authentication_bloc.dart';
import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../../router/blocs/router/router_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

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
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is! Authenticated) {
                          return const Center(
                            child: Text("no data"),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.username,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                            ),
                            Text(state.user.name),
                            Text(state.user.email),
                            const SizedBox(height: 50),
                            Text(state.user.description),
                          ],
                        );
                      },
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
