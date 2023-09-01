import 'package:flutter/material.dart';

import 'views/home_view.dart';
import 'views/new_contact_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      home: const HomeView(),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    ),
  );
}
