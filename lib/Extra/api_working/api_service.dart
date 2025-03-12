import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class ApiService {
  static const String baseUrl = 'https://67d16606825945773eb42db5.mockapi.io/userdata';

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      }
      throw Exception('Failed to load users: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<User> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()..remove('id')), // Remove ID for new user
      );
      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to add user: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<User> updateUser(String id, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to update user: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}