import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/screens/sign/signin_screen.dart';
import 'package:main/screens/sign/signup_screen.dart';

import '../router/no_animation_transition_delegate.dart';
import '../router/router_bloc.dart';

class SignScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> _signNavigatorKey = GlobalKey<NavigatorState>();
  final TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

  SignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RouterBloc, RouterState>(
        builder: (context, routerState) {
          return Navigator(
            key: _signNavigatorKey,
            transitionDelegate: transitionDelegate,
            onPopPage: (_, __) => false,
            pages: [
              const MaterialPage(
                key: ValueKey('sign signin'),
                child: SignInScreen(),
              ),
              if (routerState is SignUpRoute)
                const MaterialPage(
                  key: ValueKey('sign signup'),
                  child: SignUpScreen(),
                ),
            ],
          );
        },
      ),
    );
  }
}
