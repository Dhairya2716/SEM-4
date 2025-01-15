import 'dart:io';

void main(){

  stdout.write("Enter marks of maths : ");
  int math = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks of pc : ");
  int pc = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks of flutter : ");
  int flutter = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks of python : ");
  int python = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks of dbms : ");
  int dbms = int.parse(stdin.readLineSync()!);

  double percentage_of_subjects = (math+pc+flutter+python+dbms)/5.0;

  stdout.write("percentage of 5 subjects is : $percentage_of_subjects");
}