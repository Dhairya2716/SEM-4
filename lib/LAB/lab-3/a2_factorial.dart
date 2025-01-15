import 'dart:io';

void main(){

  stdout.write("Enter a number : ");
  int n = int.parse(stdin.readLineSync()!);

  int fac = 1;

  for(int i = 2; i<= n ; i++){
    fac *= i;
  }

  stdout.write("factorial of $n is $fac");

}