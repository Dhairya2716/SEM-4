import 'dart:io';

void main(){

  List<Map<String,dynamic>> phonebook = [

    {

      'Name' : 'Dhairya',
      'Mobile' : 123456789,
      'Email' : 'dhairya27@gmail.com'

    },
    {

      'Name' : 'kalp',
      'Mobile' : 123655789,
      'Email' : 'kalp11412@gmail.com'

    }

  ];

  stdout.write("Enter name to find data : ");
  String name = stdin.readLineSync()!;

  for(int i = 0;i<phonebook.length;i++){

    if(phonebook[i]['Name'] == name){

      stdout.write("${phonebook[i]}");
      break;

    }

  }

}