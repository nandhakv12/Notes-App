import 'package:flutter/material.dart';
import 'package:learn/constants/routes.dart';
import 'package:learn/services/auth/auth_exception.dart';
import 'package:learn/services/auth/auth_services.dart';

import '../utilities/show_error_dialouge.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter Your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter Your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthServices.firebase().createUser(
                  email: email,
                  password: password,
                );

                AuthServices.firebase().sendEmailVerification();

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordException {
                await showErrorDialog(
                  context,
                  'weak password',
                );
              } on EmailAlreadyInUseException {
                await showErrorDialog(
                  context,
                  'email-already-in-use',
                );
              } on InvalidEmailException {
                await showErrorDialog(
                  context,
                  'invalid-email',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'failed to register',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('already register login'),
          )
        ],
      ),
    );
  }
}
