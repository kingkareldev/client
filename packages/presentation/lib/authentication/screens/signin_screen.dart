import 'package:business_contract/user/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentication/blocs/authentication/authentication_bloc.dart';
import '../../core/extensions/string.dart';
import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../blocs/signin/signin_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  late final SignInBloc _signInBloc;

  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  localization.signInTitle.toTitleCase(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 50),
                BlocProvider(
                  create: (context) {
                    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
                    return _signInBloc = SignInBloc(authBloc: authBloc, authService: GetIt.I<AuthService>());
                  },
                  child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is SignInFailure) ...[
                            const Text('Fail'),
                          ] else if (state is SignInSuccess) ...[
                            const Text('Success'),
                          ],
                          SizedBox(
                            width: 400,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: _username,
                                    onChanged: (String value) {
                                      _username = value;
                                    },
                                    onFieldSubmitted: (_) => _onSubmit(),
                                    autofocus: true,
                                    decoration: InputDecoration(labelText: localization.formUsernameLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    initialValue: _password,
                                    onChanged: (String value) {
                                      _password = value;
                                    },
                                    onFieldSubmitted: (_) => _onSubmit(),
                                    decoration: InputDecoration(labelText: localization.formPasswordLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  if (state is! SignInSuccess)
                                    ElevatedButton(
                                      onPressed: _onSubmit,
                                      child: const Text('Submit'),
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _signInBloc.add(SignIn(username: _username, password: _password));
    }
  }
}
