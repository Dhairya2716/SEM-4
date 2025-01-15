import 'dart:io';

void fibo(int n){

  int a = 0;
  int b = 1;

  for(int i = 0;i<=n;i++){

    stdout.write("$a ");
    int c = a+b;
    a = b;
    b = c;

  }

}

void main(){

  stdout.write("Enter a number : ");
  int n = int.parse(stdin.readLineSync()!);

  fibo(n);
}