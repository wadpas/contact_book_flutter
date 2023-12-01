import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactsService extends ValueNotifier<List<Contact>> {
  ContactsService._sharedInstance()
      : super([
          Contact(name: 'Tod', email: 'tod@gmail.com'),
          Contact(name: 'Mark', email: 'mark@gmail.com'),
        ]);
  static final ContactsService _shared = ContactsService._sharedInstance();
  factory ContactsService() => _shared;

  void add({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    value.remove(contact);
    notifyListeners();
  }
}
