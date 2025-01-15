import 'dart:io';

void main(){

  stdout.write("Enter input : ");
  String evaluate = stdin.readLineSync()!;

  bool containsDigit(String str) {
    final regex = RegExp(r'\d');
    return regex.hasMatch(str);
  }

  for(int i = 0;i<evaluate.length;i++){
    String s = evaluate[i];
    if(containsDigit(s)){
      
    }
  }

}
// 23 + 45 - 60 / 33
// spilite(" ");
// temp = 3.2;
// remoreveAt(i-1, temp);