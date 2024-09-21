
import 'package:flutter/material.dart';

class ListViewPro with ChangeNotifier{
  
  List<String> nameList = [];

  void addName(String name){
    nameList.add(name);
    notifyListeners();
  }
}