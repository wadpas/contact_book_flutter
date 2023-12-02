import 'package:contact_book_flutter/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:contact_book_flutter/sevices/contacts_service.dart';

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final ContactsService contactsService = arguments['contactsService'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ListenableBuilder(
                    listenable: contactsService,
                    builder: (BuildContext context, Widget? child) {
                      return contactsService.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  contactsService
                                      .addContact(
                                        _nameController.text,
                                        _emailController.text,
                                      )
                                      .catchError(
                                        (error) => errorDialog(context, error),
                                      )
                                      .then(
                                        (_) => Navigator.of(context).pop(),
                                      );
                                }
                              },
                              child: const Text('Add contact'),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
