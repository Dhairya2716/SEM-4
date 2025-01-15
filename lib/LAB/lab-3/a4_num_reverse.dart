import 'dart:io';

void main(){

  stdout.write("Enter a number : ");
  int num = int.parse(stdin.readLineSync()!);

  int n = num;
  int reverse = 0;
  while(n != 0){
    int remainder = n % 10;
    reverse = reverse * 10 + remainder;
    n ~/= 10;
  }

  stdout.write("reverse of $num is $reverse");

}

