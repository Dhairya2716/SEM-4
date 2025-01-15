import 'dart:io';

void main(){

  stdout.write("Enter first number : ");
  int num1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter second number : ");
  int num2 = int.parse(stdin.readLineSync()!);

  stdout.write("choose operator to perform operation(+,-,*,/) : ");
  String operator = (stdin.readLineSync()!);

  int value = 0;
  double ans = 0;
  int count = 0;

  if(operator == '+' || operator == '-' || operator == '*' || operator == '/'){
    if(operator == '+'){
      value = num1 + num2;
    }
    if(operator == '-'){
      value = num1 - num2;
    }
    if(operator == '*'){
      value = num1 * num2;
    }
    if(operator == '/'){
      ans = num1 / num2;
      count++;
    }

    if(count != 0){
      stdout.write("$ans");
    }
    else{
      stdout.write("$value");
    }
  }
  else{
    stdout.write("Invalid input");
  }
}