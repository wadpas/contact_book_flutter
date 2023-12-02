import 'package:contact_book_flutter/sevices/auth_service.dart';
import 'package:contact_book_flutter/sevices/contacts_service.dart';
import 'package:contact_book_flutter/views/auth_view.dart';
import 'package:contact_book_flutter/widgets/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'views/contacts_view.dart';
import 'views/new_contact_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final contactsService = ContactsService();

    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 15, 100, 100),
        ),
        textTheme: GoogleFonts.archivoTextTheme(),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ContactsView(
              authService: authService,
              contactsService: contactsService,
            );
          }
          return AuthView(authService: authService);
        },
      ),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}
