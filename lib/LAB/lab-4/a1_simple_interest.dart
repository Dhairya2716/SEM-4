import 'dart:io';

void simpleinterest(int p , int r ,int t){

  double si = (p*r*t)/100.0;
  stdout.write("simple interest is $si");
}


void main(){

  stdout.write("Enter principle amount : ");
  int p = int.parse(stdin.readLineSync()!);

  stdout.write("Enter rate : ");
  int r = int.parse(stdin.readLineSync()!);

  stdout.write("Enter time taken : ");
  int t = int.parse(stdin.readLineSync()!);

  simpleinterest(p, r, t);

}