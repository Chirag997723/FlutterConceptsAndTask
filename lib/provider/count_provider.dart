import 'package:flutter/foundation.dart';

class CountProvider with ChangeNotifier {
  int counter = 0;

  
  void increment(){
    counter++;
    notifyListeners();
  }
}