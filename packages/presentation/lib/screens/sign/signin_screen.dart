import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/extensions/string.dart';

import '../../authentication/authentication_bloc.dart';
import '../../components/default_screen_container.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../sign/signin/sign_in_bloc.dart';

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
                    return _signInBloc = SignInBloc(authBloc: authBloc);
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
                                    decoration: InputDecoration(labelText: localization.formPasswordLabel),
                                    autofocus: true,
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
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _signInBloc.add(SignIn(username: _username, password: _password));
                                        }
                                      },
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
}
