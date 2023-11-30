import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/home_view.dart';
import 'views/new_contact_view.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 15, 100, 100),
        ),
        textTheme: GoogleFonts.archivoTextTheme(),
        useMaterial3: true,
      ),
      home: const HomeView(),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}
