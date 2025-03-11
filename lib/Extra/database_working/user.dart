// class Person {
//   final int? id;
//   final String name;
//   final int age;
//   final String city;
//
//   Person({this.id, required this.name, required this.age, required this.city});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//       'city': city,
//     };
//   }
//
//   factory Person.fromMap(Map<String, dynamic> map) {
//     return Person(
//       id: map['id'],
//       name: map['name'],
//       age: map['age'],
//       city: map['city'],
//     );
//   }
// }