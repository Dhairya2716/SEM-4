// void main(){
//
//   var std = Student('dhairya',2);
//   std.showinfo();
//
// }
//
// class Student{
//
//   Student(this.name,this.age);
//
//   var name;
//   var age;
//
//   showinfo(){
//       print('name is ${name}');
//       print('age is ${age}');
//   }
//
// }

void main(){

  int a = 5;
  int b = 7;
  int c = 2;
  var e;

  int d = a+b;
  e ??= c;
  print(d);
  print(e);

}