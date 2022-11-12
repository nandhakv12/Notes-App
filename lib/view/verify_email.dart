import 'package:flutter/material.dart';
import 'package:learn/constants/routes.dart';
import 'package:learn/services/auth/auth_services.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify email'),
      ),
      body: Column(
        children: [
          const Text(
              'we sent you a email verification .please open it in mail'),
          const Text('if have not recieve mail.press below..'),
          TextButton(
            onPressed: () async {
              AuthServices.firebase().sendEmailVerification();
            },
            child: const Text('snd email ver'),
          ),
          TextButton(
            onPressed: () async {
              AuthServices.firebase().logOut();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('restart'),
          )
        ],
      ),
    );
  }
}
