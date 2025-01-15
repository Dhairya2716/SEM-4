import 'dart:io';

void main(){

  stdout.write("Enter 1st number : ");
  int num1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter 2nd number : ");
  int num2 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter 3rd number : ");
  int num3 = int.parse(stdin.readLineSync()!);

  if(num1 > num2){
    if(num1 > num3){
      stdout.write("$num1 is largest among three numbers");
    }
    else{
      stdout.write("$num3 is largest among three numbers");
    }
  }
  else{
    if(num2 > num3){
      stdout.write("$num2 is largest among three numbers");
    }
    else{
      stdout.write("$num3 is largest among three numbers");
    }
  }
}