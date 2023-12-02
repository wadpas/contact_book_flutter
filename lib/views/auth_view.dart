import 'package:contact_book_flutter/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:contact_book_flutter/sevices/auth_service.dart';

class AuthView extends StatelessWidget {
  const AuthView({required this.authService, super.key});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: authService,
          builder: (BuildContext context, bool value, Widget? child) {
            return value
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Authentication',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          authService.signInWithGoogle().catchError(
                                (error) => errorDialog(context, error),
                              );
                        },
                        child: const Text('Google'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          authService.signInAnonymous().catchError(
                                (error) => errorDialog(context, error),
                              );
                        },
                        child: const Text('Anonymous'),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
