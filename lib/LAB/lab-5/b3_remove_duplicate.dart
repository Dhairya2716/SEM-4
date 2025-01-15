import 'dart:collection';
import 'dart:io';

void main(){

  List<int> nums = [1,2,2,3,3,4,4,4];
  List<int> result = [];

  HashSet<int> remove_duplicate = HashSet();

  for(int i in nums){
    remove_duplicate.add(i);
  }

  for(int j in remove_duplicate){
    result.add(j);
  }

  stdout.write(result);
}