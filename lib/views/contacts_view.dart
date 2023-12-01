import 'package:contact_book_flutter/sevices/auth_service.dart';
import 'package:flutter/material.dart';

import '../sevices/contacts_service.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            onPressed: () {
              authService.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactsService(),
        builder: (context, values, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final contact = values[index];
              return Dismissible(
                onDismissed: (direction) =>
                    ContactsService().remove(contact: contact),
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 1,
                  child: ListTile(
                    leading: Text((index + 1).toString()),
                    leadingAndTrailingTextStyle:
                        Theme.of(context).textTheme.bodyLarge,
                    title: Text(contact.name),
                    subtitle: Text(contact.email),
                    trailing: IconButton(
                      onPressed: () =>
                          ContactsService().remove(contact: contact),
                      icon: const Icon(Icons.delete),
                    ),
                    iconColor: Colors.redAccent,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-contact');
        },
      ),
    );
  }
}
