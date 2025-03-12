class User {
  final String id;
  final String name;
  final String city;
  final String age;

  User({
    required this.id,
    required this.name,
    required this.city,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      age: json['age'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'age': age,
    };
  }
}