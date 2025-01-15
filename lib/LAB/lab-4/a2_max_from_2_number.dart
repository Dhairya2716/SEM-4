import 'dart:io';
import 'dart:math';

void maxnum(int a, int b){

  int maximum = max(a,b);
  stdout.write("maximum number is $maximum");

}

void main(){

  stdout.write("Enter 1st number : ");
  int a = int.parse(stdin.readLineSync()!);

  stdout.write("Enter 2nd number : ");
  int b = int.parse(stdin.readLineSync()!);

  maxnum(a,b);

}