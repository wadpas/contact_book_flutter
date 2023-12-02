import 'package:contact_book_flutter/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:contact_book_flutter/sevices/auth_service.dart';
import 'package:contact_book_flutter/sevices/contacts_service.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({
    super.key,
    required this.authService,
    required this.contactsService,
  });

  final AuthService authService;
  final ContactsService contactsService;

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  void initState() {
    widget.contactsService.getContacts();
    super.initState();
  }

  @override
  void dispose() {
    widget.contactsService.clearContacts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            onPressed: () {
              widget.authService.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.contactsService,
        builder: (BuildContext context, Widget? child) {
          return widget.contactsService.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: widget.contactsService.contacts.length,
                  itemBuilder: (_, index) {
                    final contact = widget.contactsService.contacts[index];
                    return Dismissible(
                      onDismissed: (direction) =>
                          widget.contactsService.removeContact(contact),
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
                            onPressed: () => widget.contactsService
                                .removeContact(contact)
                                .catchError(
                                  (error) => errorDialog(context, error),
                                ),
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
          await Navigator.of(context).pushNamed('/new-contact', arguments: {
            'contactsService': widget.contactsService,
          });
        },
      ),
    );
  }
}
