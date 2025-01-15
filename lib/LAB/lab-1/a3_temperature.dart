import 'dart:io';

void main(){

  stdout.write("Enter value of fahrenheit : ");
  int F = int.parse(stdin.readLineSync()!);

  double C = (F-32)*(5/9.0);

  stdout.write("$F fahrenheit is equal to $C celcius");
}