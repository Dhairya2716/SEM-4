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

  if(percentage_of_subjects < 35){
    stdout.write("Fail");
  }
  else if(percentage_of_subjects >= 35 && percentage_of_subjects < 45){
    stdout.write("pass");
  }
  else if(percentage_of_subjects >= 45 && percentage_of_subjects < 60){
    stdout.write("second");
  }
  else if(percentage_of_subjects >= 60 && percentage_of_subjects < 70){
    stdout.write("first");
  }
  else if(percentage_of_subjects >= 70){
    stdout.write("distinct");
  }
}