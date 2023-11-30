import 'package:flutter/material.dart';

import '../state/contact_book.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, values, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final contact = values[index];
              return Dismissible(
                onDismissed: (direction) =>
                    ContactBook().remove(contact: contact),
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
                      onPressed: () => ContactBook().remove(contact: contact),
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
