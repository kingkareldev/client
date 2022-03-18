import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'authentication/blocs/authentication/authentication_bloc.dart';
import 'core/l10n/gen/app_localizations.dart';
import 'router/app_router_delegate.dart';
import 'router/blocs/router/router_bloc.dart';
import 'router/route_information_parser.dart';
import 'settings/settings_controller.dart';

class KingKarel extends StatefulWidget {
  final SettingsController settingsController;

  const KingKarel({required this.settingsController, Key? key}) : super(key: key);

  @override
  State<KingKarel> createState() => _KingKarelState();
}

class _KingKarelState extends State<KingKarel> {
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  late final AuthenticationBloc _authenticationBloc;
  late final RouterBloc _routerBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    _routerBloc = RouterBloc(authBloc: _authenticationBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return BlocProvider<RouterBloc>(
            create: (_) => _routerBloc,
            child: Builder(
              builder: (BuildContext innerContext) {
                return MaterialApp.router(
                  restorationScopeId: 'kingkarel',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                  ],
                  onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    buttonTheme: const ButtonThemeData(
                      hoverColor: Colors.blue,
                    ),
                    textTheme: const TextTheme(
                      headline4: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  darkTheme: ThemeData.dark(),
                  themeMode: widget.settingsController.themeMode,
                  routerDelegate: AppRouterDelegate(routerBloc: BlocProvider.of<RouterBloc>(innerContext)),
                  routeInformationParser: _routeInformationParser,
                  backButtonDispatcher: RootBackButtonDispatcher(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
