import 'package:contact_book_flutter/sevices/auth_service.dart';
import 'package:flutter/material.dart';

import '../sevices/contacts_service.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  final contactsService = ContactsService();
  final authService = AuthService();

  @override
  void initState() {
    contactsService.getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListenableBuilder(
        listenable: contactsService,
        builder: (BuildContext context, Widget? child) {
          return contactsService.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: contactsService.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contactsService.contacts[index];
                    return Dismissible(
                      onDismissed: (direction) =>
                          contactsService.remove(contact),
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
                            onPressed: () => contactsService.remove(contact),
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
