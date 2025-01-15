import 'dart:io';

void main(){

  List<int> nums = [3,2,4];
  int target = 6;
  List<int> index = [];

  for(int i = 0;i<nums.length;i++){

    for(int j = 0;j<nums.length;j++){

      if(i == j){
        continue;
      }
      else{
        if(nums[i] + nums[j] == target){
          index.add(i);
          index.add(j);
          break;
        }
      }

    }

  }

  stdout.write(index);

}