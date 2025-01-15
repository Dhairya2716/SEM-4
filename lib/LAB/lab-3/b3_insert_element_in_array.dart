import 'dart:io';

void main(){

  List<int> arr = [1,2,3,5];
  stdout.write("orignal array is $arr");
  
  arr.insert(3, 4);

  print(" ");
  stdout.write("after inserting array is $arr");

}