import 'dart:io';

int check({required int num}){

  for(int i = 2; i < num / 2; i++){

    if(num % i == 0){
      return 0;
    }

  }
  return 1;
}

void main(){

  stdout.write("Enter a number : ");
  int num = int.parse(stdin.readLineSync()!);

  if(check(num :num) == 1){
    stdout.write("prime");
  }
  else{
    stdout.write("not a prime");
  }

}