import 'dart:io';

void main(){

  stdout.write("Enter starting number : ");
  int start = int.parse(stdin.readLineSync()!);

  stdout.write("Enter ending number : ");
  int end = int.parse(stdin.readLineSync()!);

  stdout.write("number between $start and $end which is divisible by 2 but not 3 : ");
  print(" ");

  for(start; start < end;start++){
    if(start % 2 == 0 && start % 3 != 0){
      stdout.write("$start ");
    }
  }
}