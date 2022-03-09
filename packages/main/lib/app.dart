import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:main/authentication/authentication_bloc.dart';

import 'router/app_router_delegate.dart';
import 'router/route_information_parser.dart';
import 'router/router_bloc.dart';
import 'settings/settings_controller.dart';

class App extends StatefulWidget {
  final SettingsController settingsController;

  const App({required this.settingsController, Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
                      headline4: TextStyle(
                          fontWeight: FontWeight.w700
                      ),
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
