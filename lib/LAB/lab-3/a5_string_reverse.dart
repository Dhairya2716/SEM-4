import 'dart:io';

void main(){

  stdout.write("Enter a string : ");
  String value = stdin.readLineSync()!;

  String reverse = " ";

  for(int i = 0;i<value.length;i++){

    String c = value[i];

    reverse = c + reverse;

  }

  stdout.write("reverse of $value is $reverse");

}