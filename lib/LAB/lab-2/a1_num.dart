import 'dart:io';

void main(){

  stdout.write("Enter a number : ");
  int n = int.parse(stdin.readLineSync()!);

  if(n >= 0){
    stdout.write("$n is positive");
  }
  else{
    stdout.write("$n is negative");
  }

}