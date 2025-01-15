import 'dart:io';

void main(){

  stdout.write("Enter value of measurment in meter : ");
  int m = int.parse(stdin.readLineSync()!);

  double f = 3.28084*m;

  stdout.write("$m meter is equal to $f feet");
}