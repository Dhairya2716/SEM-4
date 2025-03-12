import 'package:flutter/material.dart';
import 'user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}\'s Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('City: ${user.city}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Age: ${user.age}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}