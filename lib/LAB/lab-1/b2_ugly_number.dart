import 'dart:io';

void main(){

  stdout.write("Enter a number : ");
  int n = int.parse(stdin.readLineSync()!);

  int num = n;

  while(n % 2 == 0){
    n ~/= 2;
  }

  while(n % 3 == 0){
    n ~/= 3;
  }

  while(n % 5 == 0){
    n ~/= 5;
  }

  if(n == 1){
    stdout.write("given number $num is ugly number");
  }
  else{
    stdout.write("given number $num is not an ugly number");
  }

}