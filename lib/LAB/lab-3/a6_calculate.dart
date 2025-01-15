import 'dart:io';

void main(){

  stdout.write("you have to enter a number to to be calculated i.e if "
      "number is +ve and even than added or number is -ve and odd then add and to end the game enter 0");

  print(" ");

  stdout.write("Would you like to start calculation(y/n) : ");
  String input = stdin.readLineSync()!;

  print(" ");

  int result = 0;

  if(input == 'y'){

    bool flag = true;

    while(flag) {

      stdout.write("Enter a number ");
      int num = int.parse(stdin.readLineSync()!);

      if(num > 0 && num % 2 == 0){
        result += num;
      }
      if(num < 0 && num % 2 == 1){
        result += num;
      }
      if(num == 0){
        flag = false;
      }

    }
    stdout.write("value is $result");
  }
  if(input == 'n'){
    stdout.write("ok bye");
  }

}