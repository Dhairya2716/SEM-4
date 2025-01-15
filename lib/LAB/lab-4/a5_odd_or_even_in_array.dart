import 'dart:io';

int evencount = 0;
int oddcount = 0;


void even(int evennum){
  evencount++;
}

void odd(int oddnum){
  oddcount++;
}

void main(){

  var arr = [1,2,3,4,5];

  for(int i = 0;i < arr.length;i++){

    if(arr[i] % 2 == 0){
      even(evencount);
    }
    else{
      odd(oddcount);
    }

  }

  stdout.write("total odd numbers are : $oddcount");
  print(" ");
  stdout.write("total even numbers are : $evencount");

}