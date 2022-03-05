import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/app_router_delegate.dart';
import 'router/route_information_parser.dart';
import 'router/router_bloc.dart';
import 'settings/settings_controller.dart';

class App extends StatelessWidget {
  final SettingsController settingsController;

  App({required this.settingsController, Key? key}) : super(key: key);

  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();


  @override
  Widget build(BuildContext context) {
    return BlocProvider<RouterBloc>(
      create: (_) => RouterBloc(),
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
            themeMode: settingsController.themeMode,
            routerDelegate: AppRouterDelegate(routerBloc: BlocProvider.of<RouterBloc>(innerContext)),
            routeInformationParser: _routeInformationParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
