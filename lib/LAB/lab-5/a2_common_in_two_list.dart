import 'dart:collection';
import 'dart:io';

void main(){

  List<int> nums1 = [1,2,3];
  List<int> nums2 = [2,3,2];
  List<int> common = [];

  for(int i = 0;i<nums1.length;i++){

    for(int j = 0;j<nums2.length;j++){

      if(nums1[i] == nums2[j]){
        common.add(nums1[i]);
      }

    }

  }

  HashSet<int> number = HashSet();

  for(int j in common){
    number.add(j);
  }

  stdout.write(number);

}