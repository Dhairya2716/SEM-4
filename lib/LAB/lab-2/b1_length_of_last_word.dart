import 'dart:io';

void main(){

  stdout.write("Enter a sentence : ");
  String sentence = stdin.readLineSync()!;

  int count = 0;

  for(int i = sentence.length-1;i>= 0;i--){
    if(sentence[i]==" "){
      break;
    }
    count++;
  }

  stdout.write("length of last word is : $count");

}