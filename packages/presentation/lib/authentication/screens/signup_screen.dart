import 'package:business_contract/user/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentication/blocs/authentication/authentication_bloc.dart';
import '../../core/extensions/string.dart';
import '../../core/l10n/gen/app_localizations.dart';
import '../../core/widgets/default_screen_container.dart';
import '../blocs/signup/signup_bloc.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  localization.signUpTitle.toTitleCase(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 50),
                BlocProvider(
                  create: (context) {
                    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
                    return _signInBloc = SignUpBloc(authBloc: authBloc, authService: GetIt.I<AuthService>());
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
                                    onFieldSubmitted: (_) => _onSubmit(),
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
                                    onFieldSubmitted: (_) => _onSubmit(),
                                    decoration: InputDecoration(labelText: localization.formPasswordLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: _realName,
                                    onChanged: (String value) {
                                      _realName = value;
                                    },
                                    onFieldSubmitted: (_) => _onSubmit(),
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
                                    onFieldSubmitted: (_) => _onSubmit(),
                                    decoration: InputDecoration(labelText: localization.formEmailLabel),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.formFieldValidatorEmptyText;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: _description,
                                    onChanged: (String value) {
                                      _description = value;
                                    },
                                    onFieldSubmitted: (_) => _onSubmit(),
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
      _signInBloc.add(SignUp(
        username: _username,
        password: _password,
        realName: _realName,
        email: _email,
        description: _description,
      ));
    }
  }
}
