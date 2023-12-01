import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactsService extends ValueNotifier<Map<String, dynamic>> {
  ContactsService()
      : super({
          'isLoading': false,
          'contacts': [],
        });

  final db = FirebaseFirestore.instance;

  Future getContacts() async {
    value['isLoading'] = true;
    notifyListeners();

    if (value['contacts'].isEmpty) {
      await db.collection("contacts").get().then(
        (snapshot) {
          for (var contact in snapshot.docs) {
            Contact newContact = Contact(
              name: contact['name'],
              email: contact['email'],
              id: contact.id,
            );
            value['contacts'].add(newContact);
          }
        },
      );
    }
    value['isLoading'] = false;
    notifyListeners();
  }

  Future addContact(String name, String email) async {
    value['isLoading'] = true;
    notifyListeners();

    final payload = {
      'name': name,
      'email': email,
    };

    final fireDocumentId =
        await db.collection('contacts').add(payload).then((value) => value.id);

    final newContact = Contact(
      name: name,
      email: email,
      id: fireDocumentId,
    );

    value['contacts'].add(newContact);
    value['isLoading'] = false;
    notifyListeners();
  }

  void remove(Contact contact) async {
    value['contacts'].remove(contact);
    notifyListeners();
  }
}
