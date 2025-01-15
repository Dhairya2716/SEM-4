import 'dart:io';
import 'dart:math';

void main(){
  
  stdout.write("Enter value of hour : ");
  int h = int.parse(stdin.readLineSync()!);

  stdout.write("Enter value of minutes : ");
  int m = int.parse(stdin.readLineSync()!);

  if (h == 12) {
    h = 0;
  }
  if (m == 60) {
    m = 0;
    h += 1;
    if (h > 12) {
      h = h - 12;
    }
  }

  double hourangle = (0.5 * (h * 60 + m));
  double minuteangle = (6.0 * m);

  double angle = (hourangle - minuteangle).abs();

  angle = min(360 - angle, angle);

  stdout.write("$angle");

  
}