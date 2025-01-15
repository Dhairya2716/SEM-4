import 'dart:io';

void main(){

  List<int> nums = [];


  for(int i = 0;i < 5;i++){
    stdout.write("Enter value at $i position: ");
    int n = int.parse(stdin.readLineSync()!);
    nums.add(n);
  }

  stdout.write("before sorting $nums");

  nums.sort();
  print(" ");

  stdout.write("after sorting $nums");
}