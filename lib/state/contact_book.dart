import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance()
      : super([
          Contact(name: 'Tod', email: 'tod@gmail.com'),
          Contact(name: 'Mark', email: 'mark@gmail.com'),
        ]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  void add({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    value.remove(contact);
    notifyListeners();
  }
}
