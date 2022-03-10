import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/extensions/string.dart';

import '../../authentication/authentication_bloc.dart';
import '../../components/default_screen_container.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../sign/signup/signup_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late final SignUpBloc _signInBloc;

  String _username = "";
  String _password = "";
  String _realName = "";
  String _email = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return DefaultScreenContainer(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 200),
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
                    return _signInBloc = SignUpBloc(authBloc: authBloc);
                  },
                  child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is SignUpFailure) ...[
                            const Text('Fail'),
                          ] else if (state is SignUpSuccess) ...[
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
                                    autofocus: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    onChanged: (String value) {
                                      _password = value;
                                    },
                                    decoration: InputDecoration(labelText: localization.formPasswordLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    initialValue: _realName,
                                    onChanged: (String value) {
                                      _realName = value;
                                    },
                                    decoration: InputDecoration(labelText: localization.formRealNameLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: _email,
                                    onChanged: (String value) {
                                      _email = value;
                                    },
                                    decoration: InputDecoration(labelText: localization.formEmailLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    initialValue: _description,
                                    onChanged: (String value) {
                                      _description = value;
                                    },
                                    decoration: InputDecoration(labelText: localization.formDescriptionLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  if (state is! SignUpSuccess)
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _signInBloc.add(SignUp(username: _username, password: _password, realName: _realName, email: _email, description: _description));
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
