import 'dart:io';

void main(){

  List<int> num = [1,2,1,2,3];
  Map<int, int> frequency = {};

  for(int value in num){
    if(frequency.containsKey(value)){
      frequency[value] = frequency[value]!+1;
    }
    else{
      frequency[value] = 1;
    }
  }

  for(int value in frequency.keys){

    if(frequency[value] == 1){
      stdout.write("single value is $value");
      return;
    }

  }

}