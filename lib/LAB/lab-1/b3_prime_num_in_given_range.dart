import 'dart:io';

void main(){

  stdout.write("Enter starting number : ");
  int start = int.parse(stdin.readLineSync()!);

  stdout.write("Enter ending number : ");
  int end = int.parse(stdin.readLineSync()!);

  int flag;

  stdout.write("prime numbers are : ");

  for(int i = start;i <= end;i++){

    if(i == 0 || i == 1){
      continue;
    }

    flag = 1;

    for (int j = 2; j <= i / 2; ++j) {
      if (i % j == 0) {
        flag = 0;
        break;
      }
    }

    if(flag == 1){

      stdout.write("$i ");

    }

  }

}