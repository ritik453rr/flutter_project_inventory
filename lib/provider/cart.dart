import 'package:flutter/material.dart';
import 'package:kitchen_app/model/product.dart';

class Cart extends ChangeNotifier {
  //Cart list to store items
  List<Product> cartProducts = [];
  int itemCount = 0;
  double total = 0;

  //function to add item in cart
  void addItem(Product item) {
    cartProducts.add(item);
    notifyListeners();
  }

   //function to remove item  from cart
  void removeItem(Product item) {
    cartProducts.remove(item);
    notifyListeners();
  }

  //remove the same item multiple time from cart
  void removeAll(Product item){
    cartProducts.removeWhere((element) => element==item);
    notifyListeners();
  }


  //function to increament the item count
  void increaseItemCount(){
    itemCount++;
    notifyListeners();
  }

  //function to decreament the item count
  void decreaseItemCount(){
    itemCount--;
    notifyListeners();
  }

   //function to calculate total price of cart items
  void calculateTotal() {
    total=0;
    for(final item in cartProducts){
      total=total+item.price;
    }
    notifyListeners();
  }

  void checkOut(){
    itemCount=0;
    total=0;
    cartProducts=[];
    notifyListeners();
  }

}
