import 'dart:io';

void main(){

    String value = "4106";
    int n = int.parse(value);
    int len = value.length;

    while(len != 0){

      if(n % 2 == 0){
        n ~/= 10;
        len--;
      }
      else{
        len = 0;
      }
    }

    if(n == 0){
      stdout.write("output is : null");
    }
    else{
      String answer = n.toString();
      stdout.write("output is $answer");
    }

}