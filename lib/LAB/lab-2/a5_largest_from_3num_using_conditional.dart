import 'dart:io';

void main(){

  stdout.write("Enter value of 1st number : ");
  int x = int.parse(stdin.readLineSync()!);

  stdout.write("Enter value of 2nd number : ");
  int y = int.parse(stdin.readLineSync()!);

  stdout.write("Enter value of 3rd number : ");
  int z = int.parse(stdin.readLineSync()!);

  int largest = z > (x>y ? x:y) ? z:((x>y) ? x:y);

  stdout.write("$largest is largest among the 3 numbers");
}