import 'dart:io';

void main(){

  stdout.write("Enter value of weight in pounds : ");
  int w = int.parse(stdin.readLineSync()!);

  stdout.write("Enter value of height in inch : ");
  int h = int.parse(stdin.readLineSync()!);

  double weight_in_kg = w * 0.45359237;
  double height_in_meter = h * 0.0254;

  double bmi = weight_in_kg / (height_in_meter*height_in_meter);

  stdout.write("bmi is $bmi");

}