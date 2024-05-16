import 'package:flutter/material.dart';
import 'package:kitchen_app/model/product.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/screens/drawar_screen.dart';
import 'package:provider/provider.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => TabbarScreenState();
}

class TabbarScreenState extends State<TabbarScreen> {
  //List of all snacks
  List<Product> snacksList = [
    Product(id: 2, name: 'Lays', price: 15, category: 'Snacks'),
    Product(id: 3, name: 'Takatak', price: 10, category: 'Snacks'),
    Product(id: 4, name: 'Coconut Biscuit', price: 10, category: 'Snacks'),
    Product(id: 5, name: 'Parle G', price: 10, category: 'Snacks'),
    Product(id: 7, name: 'Kurkure', price: 10, category: 'Snacks'),
    Product(id: 8, name: 'Chips', price: 50, category: 'Snacks'),
    Product(id: 10, name: 'Pringles', price: 50, category: 'Snacks'),
    Product(id: 11, name: 'Sandwich', price: 25, category: 'Snacks'),
    Product(id: 13, name: 'Punjabi Tadka', price: 10, category: 'Snacks'),
    Product(id: 18, name: 'Aalu Bhujiya', price: 10, category: 'Snacks'),
    Product(id: 19, name: 'Teda Meda', price: 10, category: 'Snacks'),
    Product(id: 20, name: 'Banana Chips', price: 20, category: 'Snacks'),
  ];
  //List of all Beverage
  List<Product> beverageList = [
    Product(id: 1, name: 'Pepsi (100ml)', price: 20, category: 'Beverage'),
    Product(id: 9, name: 'Sprite', price: 20, category: 'Beverage'),
    Product(id: 15, name: 'Sprite', price: 40, category: 'Beverage'),
    Product(id: 16, name: 'String', price: 20, category: 'Beverage'),
    Product(id: 17, name: 'Frooti', price: 10, category: 'Beverage'),
    Product(id: 25, name: 'CokaCola', price: 90, category: 'Beverage'),
  ];
  //List of all Chocolate and Candy items
  List<Product> chocoCandyList = [
    Product(
        id: 6, name: 'Dairy Milk', price: 20, category: 'Chocolate and Candy'),
    Product(id: 12, name: 'Kitkat', price: 10, category: 'Chocolate and Candy'),
    Product(id: 14, name: 'KitKat', price: 20, category: 'Chocolate and Candy'),
    Product(id: 29, name: 'Perk', price: 40, category: 'Chocolate and Candy'),
    Product(
        id: 35,
        name: 'Chupa Chups',
        price: 10,
        category: 'Chocolate and Candy'),
    Product(id: 39, name: 'Munch', price: 20, category: 'Chocolate and Candy'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Consumer<Cart>(
        builder: (context, cart, child) => Scaffold(
          drawer: const DrawerScreen(),
          appBar: AppBar(
            title: const Text(
              'inventory',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade700,
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.black38,
              tabs: [
                Tab(
                  child: Text(
                    'Snacks',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Beverage',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Chocolate and Candy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: cart.cartProducts.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Item:${cart.itemCount}',
                        style: const TextStyle(fontSize: 27),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Total:${cart.total}',
                        style: const TextStyle(fontSize: 17),
                      ),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Continue to Payment',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(''),
          body: TabBarView(
            children: [
              //Displaying Snacks item
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: snacksList.length,
                  itemBuilder: (context, index) {
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(snacksList[index]);
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 5,
                        left: 9,
                        right: 9,
                      ),
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          tileColor: Colors.black12,
                          onTap: () {
                            if (cart.cartProducts.contains(snacksList[index])) {
                              cart
                                ..removeAll(snacksList[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(snacksList[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          //Title
                          title: Text(snacksList[index].name),
                          //Subtitle
                          subtitle: Text('\u{20B9}${snacksList[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value:
                                cart.cartProducts.contains(snacksList[index]),
                            onChanged: (value) {
                              if (cart.cartProducts
                                  .contains(snacksList[index])) {
                                cart
                                  ..removeAll(snacksList[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(snacksList[index])
                                  ..increaseItemCount()
                                  ..calculateTotal();
                              }
                            },
                          ),
                          trailing: itemAlreadyInCart
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cart.removeItem(snacksList[index]);
                                        if (!cart.cartProducts.contains(
                                          snacksList[index],
                                        )) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item == snacksList[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(snacksList[index])
                                          ..calculateTotal();
                                      },
                                    ),
                                  ],
                                )
                              : const Text(''),
                        ),
                      ),
                    );
                  },
                ),
              ),
              //Displaying beverage items
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: beverageList.length,
                  itemBuilder: (context, index) {
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(beverageList[index]);
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 5,
                        left: 9,
                        right: 9,
                      ),
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          tileColor: Colors.black12,
                          onTap: () {
                            if (cart.cartProducts
                                .contains(beverageList[index])) {
                              cart
                                ..removeAll(beverageList[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(beverageList[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          //Title
                          title: Text(beverageList[index].name),
                          //Subtitle
                          subtitle:
                              Text('\u{20B9}${beverageList[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value:
                                cart.cartProducts.contains(beverageList[index]),
                            onChanged: (value) {
                              if (cart.cartProducts
                                  .contains(beverageList[index])) {
                                cart
                                  ..removeAll(beverageList[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(beverageList[index])
                                  ..increaseItemCount()
                                  ..calculateTotal();
                              }
                            },
                          ),
                          trailing: itemAlreadyInCart
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cart.removeItem(beverageList[index]);
                                        if (!cart.cartProducts.contains(
                                          snacksList[index],
                                        )) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item == beverageList[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(beverageList[index])
                                          ..calculateTotal();
                                      },
                                    ),
                                  ],
                                )
                              : const Text(''),
                        ),
                      ),
                    );
                  },
                ),
              ),
              //Displaying Chocolate and Candy items
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: chocoCandyList.length,
                  itemBuilder: (context, index) {
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(chocoCandyList[index]);
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 5,
                        left: 9,
                        right: 9,
                      ),
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          tileColor: Colors.black12,
                          onTap: () {
                            if (cart.cartProducts
                                .contains(chocoCandyList[index])) {
                              cart
                                ..removeAll(chocoCandyList[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(chocoCandyList[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          //Title
                          title: Text(chocoCandyList[index].name),
                          //Subtitle
                          subtitle:
                              Text('\u{20B9}${chocoCandyList[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value: cart.cartProducts
                                .contains(chocoCandyList[index]),
                            onChanged: (value) {
                              if (cart.cartProducts
                                  .contains(chocoCandyList[index])) {
                                cart
                                  ..removeAll(chocoCandyList[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(chocoCandyList[index])
                                  ..increaseItemCount()
                                  ..calculateTotal();
                              }
                            },
                          ),
                          trailing: itemAlreadyInCart
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cart.removeItem(chocoCandyList[index]);
                                        if (!cart.cartProducts.contains(
                                          chocoCandyList[index],
                                        )) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item ==
                                                chocoCandyList[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(chocoCandyList[index])
                                          ..calculateTotal();
                                      },
                                    ),
                                  ],
                                )
                              : const Text(''),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
