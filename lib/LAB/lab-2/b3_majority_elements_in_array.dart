import 'dart:io';

void main(){

  List<int> arr = [1,1,2,3,4,5,8,1,2,4,8,7,5];

  arr.sort();
  int maxcount = 0;
  int currentcount = 1;

  for(int i = 1;i<arr.length;i++){

    if(arr[i] == arr[i-1]){
      currentcount++;
    }
    else{
      if(currentcount > maxcount){
        maxcount = currentcount;
      }
      currentcount = 1;
    }
  }

  if(currentcount > maxcount){
    maxcount = currentcount;
  }

  stdout.write("max is $maxcount");
}