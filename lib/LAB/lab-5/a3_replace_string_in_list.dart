import 'dart:io';

void main(){

  List<String> place = ["Delhi","Mumbai","Bangalore","Hyderabad","Ahmedabad"];

  for(int i = 0;i<place.length;i++){
      
    if(place[i] == "Ahmedabad"){
      place.remove("Ahmedabad");
      place.insert(i, "surat");
    }
    
  }
  
  stdout.write(place);

}