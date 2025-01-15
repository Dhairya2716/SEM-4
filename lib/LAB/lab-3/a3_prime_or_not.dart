import 'dart:io';

void main(){

  stdout.write("Enter a number : ");
  int num = int.parse(stdin.readLineSync()!);

  int count = 0;

  for(int i = 2; i <= num / 2;i++){
    if(num % i == 0){
      count++;
    }
  }

  if(count == 0){
    stdout.write("given number $num is prime");
  }
  else{
    stdout.write("given number $num is not a prime");
  }
}