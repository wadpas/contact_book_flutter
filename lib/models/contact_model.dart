import 'package:uuid/uuid.dart';

class Contact {
  final String id;
  final String name;
  final String email;
  Contact({
    required this.name,
    required this.email,
  }) : id = const Uuid().v4();
}
