import 'dart:io';

void main(){

  List<int> num = [];

  bool flag = true;
  int sum = 0;

  while(flag){

    stdout.write("1. Insert element \n2. exit");
    print(" ");
    stdout.write("Enter choice : ");
    int choice = int.parse(stdin.readLineSync()!);


    switch(choice){

      case 1:

        stdout.write("Enter value : ");
        int n = int.parse(stdin.readLineSync()!);
        num.add(n);

        if(n % 3 == 0 || n % 5 == 0){
          sum += n;
        }

        break;

      case 2:
        flag = false;
        break;

      default:
        stdout.write("Invalid input");
    }

  }

  print(" ");
  stdout.write("number in list are : $num");
  print(" ");
  stdout.write("sum of all number which are divisible by 3 or 5 is : $sum");

}