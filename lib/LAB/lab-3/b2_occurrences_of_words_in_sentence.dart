import 'dart:io';

void main(){

  stdout.write("Enter a sentence : ");
  String line = stdin.readLineSync()!;

  Map<String,int> set = {};

  List<String> words = line.toLowerCase().split(RegExp(r'\W+'));

  for(String word in words){

    if(word.isNotEmpty){
      set.putIfAbsent(word, () => 0);
      set[word] = set[word]! + 1;
    }
  }

    stdout.write("$set");

}