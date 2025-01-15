import 'dart:io';

void main(){

    var arr = [-2, 1, -3, 4, -1, 2, 1, -5, 4];

    int max = arr[0];
    int begin = 0;
    int end = 0;
    int sum = 0;

    while(end < arr.length){

      sum += arr[end];

      if(sum < 0){
        sum = 0;
        begin = end + 1;
      }
      else{
        if(sum > max){
          max = sum;
        }
      }
    end++;
    }
  stdout.write("value is $max");
}