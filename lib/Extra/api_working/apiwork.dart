import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const UserApp());

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserScreen(),
    );
  }
}

class User {
  final String id, name, city, age;

  User(
      {required this.id,
      required this.name,
      required this.city,
      required this.age});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        city: json['city'],
        age: json['age'],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'city': city, 'age': age};
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  static const String baseUrl =
      'https://67d16606825945773eb42db5.mockapi.io/userdata';
  List<User> userList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        setState(() {
          userList = (jsonDecode(res.body) as List)
              .map((json) => User.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        throw 'Failed to load: ${res.statusCode}';
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> addUser(User user) async {
    final res = await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()..remove('id')));
    if (res.statusCode == 201) {
      setState(() => userList.add(User.fromJson(jsonDecode(res.body))));
    } else {
      throw 'Failed to add: ${res.statusCode}';
    }
  }

  Future<void> updateUser(String id, User user) async {
    final res = await http.put(Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    if (res.statusCode == 200) {
      setState(() {
        final index = userList.indexWhere((u) => u.id == id);
        if (index != -1) userList[index] = User.fromJson(jsonDecode(res.body));
      });
    } else {
      throw 'Failed to update: ${res.statusCode}';
    }
  }

  Future<void> deleteUser(String id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode == 200) {
      setState(() => userList.removeWhere((u) => u.id == id));
    } else {
      throw 'Failed to delete: ${res.statusCode}';
    }
  }

  Future<void> showUserDialog([User? user]) async {
    final isEdit = user != null;
    final nameCtrl = TextEditingController(text: user?.name);
    final cityCtrl = TextEditingController(text: user?.city);
    final ageCtrl = TextEditingController(text: user?.age);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEdit ? 'Edit User' : 'Add User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: cityCtrl,
                decoration: const InputDecoration(labelText: 'City')),
            TextField(
                controller: ageCtrl,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              if (nameCtrl.text.isNotEmpty &&
                  cityCtrl.text.isNotEmpty &&
                  ageCtrl.text.isNotEmpty) {
                final newUser = User(
                    id: user?.id ?? '',
                    name: nameCtrl.text,
                    city: cityCtrl.text,
                    age: ageCtrl.text);
                try {
                  isEdit
                      ? await updateUser(user!.id, newUser)
                      : await addUser(newUser);
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$e')));
                }
              }
            },
            child: Text(isEdit ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        // actions: [
        //   IconButton(icon: const Icon(Icons.refresh), onPressed: fetchUsers)
        // ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userList.isEmpty
              ? const Center(child: Text('No users'))
              : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, i) {
                    final user = userList[i];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text('${user.city}, Age: ${user.age}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => showUserDialog(user)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Delete?'),
                                  content: const Text('Are you sure?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Yes',
                                            style:
                                                TextStyle(color: Colors.red))),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                try {
                                  await deleteUser(user.id);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('$e')));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
          onPressed: showUserDialog, child: const Icon(Icons.add)),
    );
  }
}