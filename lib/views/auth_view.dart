import 'package:contact_book_flutter/sevices/auth_service.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
      ),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: authService,
            builder: (context, value, child) {
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
                            authService.signInWithGoogle().catchError((e) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(e.message.toString()),
                                  );
                                },
                              );
                            });
                          },
                          child: const Text('Google'),
                        )
                      ],
                    );
            }),
      ),
    );
  }
}
