import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactsService extends ChangeNotifier {
  bool _isLoading = false;
  final List<Contact> _contacts = [];
  bool get isLoading => _isLoading;
  List<Contact> get contacts => _contacts;

  final db = FirebaseFirestore.instance;

  Future getContacts() async {
    _isLoading = true;
    notifyListeners();

    await db.collection("contacts").get().then(
      (snapshot) {
        for (var contact in snapshot.docs) {
          Contact newContact = Contact(
            name: contact['name'],
            email: contact['email'],
            id: contact.id,
          );
          _contacts.add(newContact);
        }
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future addContact(String name, String email) async {
    _isLoading = true;
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

    _contacts.add(newContact);
    _isLoading = false;
    notifyListeners();
  }

  Future removeContact(Contact contact) async {
    _isLoading = true;
    notifyListeners();

    await db.collection('contacts').doc(contact.id).delete();

    _contacts.remove(contact);
    _isLoading = false;
    notifyListeners();
  }

  void clearContacts() {
    _contacts.clear();
  }
}
