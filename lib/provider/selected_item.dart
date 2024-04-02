import 'package:flutter/material.dart';
class SelectedItemIndex extends ChangeNotifier{
  int selectedNavIndex=0;
  
   void allProduct(){
    selectedNavIndex=0;
    notifyListeners();
   }
    void profile(){
    selectedNavIndex=1;
    notifyListeners();
   }
}
