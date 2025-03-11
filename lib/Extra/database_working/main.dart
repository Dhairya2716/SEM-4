import 'package:flutter/material.dart';
import 'database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final data = await DatabaseHelper.instance.getUsers();
    setState(() => users = data);
  }

  void _showUserDialog({int? id}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController cityController = TextEditingController();

    if (id != null) {
      final user = users.firstWhere((u) => u['id'] == id);
      nameController.text = user['name'];
      ageController.text = user['age'];
      cityController.text = user['city'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? "Add User" : "Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
              TextField(controller: ageController, decoration: InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
              TextField(controller: cityController, decoration: InputDecoration(labelText: "City")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String age = ageController.text;
                String city = cityController.text;
                if (name.isNotEmpty && age.isNotEmpty && city.isNotEmpty) {
                  if (id == null) {
                    await DatabaseHelper.instance.addUser({'name': name, 'age': age, 'city': city});
                  } else {
                    await DatabaseHelper.instance.updateUser({'id': id, 'name': name, 'age': age, 'city': city});
                  }
                  _loadUsers();
                  Navigator.pop(context);
                }
              },
              child: Text(id == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: users.isEmpty
          ? Center(child: Text("No users added yet"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name']),
            subtitle: Text("Age: ${users[index]['age']}, City: ${users[index]['city']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _showUserDialog(id: users[index]['id'])),
                IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteUser(users[index]['id'])),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showUserDialog(),
      ),
    );
  }
}