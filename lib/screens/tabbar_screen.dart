import 'package:flutter/material.dart';
import 'package:kitchen_app/model/product.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/screens/drawar_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
    Product(id: 90, name: 'Water Bottle', price: 20, category: 'Beverage'),
    Product(id: 91, name: 'Limca', price: 40, category: 'Beverage'),
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
    Product(id: 95, name: 'Gems', price: 10, category: 'Chocolate and Candy'),
  ];

  // Search query
  String searchQuery = '';

  //Instance of razorpay
  final _razorpay = Razorpay();
  int initialIndex = 0;

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Provider.of<Cart>(context, listen: false).checkOut();
    initialIndex = 0;
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void initState() {
    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  List<Product> _getFilteredProducts(List<Product> products) {
    if (searchQuery.isEmpty) {
      return products;
    } else {
      return products
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()),)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 3,
      child: Consumer<Cart>(
        builder: (context, cart, child) => Scaffold(
          drawer: const DrawerScreen(),
          appBar: AppBar(
            title: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search Product.....',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                 focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade700,
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.black38,
              labelPadding: EdgeInsets.only(right: 45),
              tabs: [
                Tab(
                  child: Text(
                    'Snacks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Beverage',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    'Chocolate and Candy',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                            onPressed: () {
                              final options = {
                                'key': 'rzp_test_oju4wyTNGl4Jro',
                                'amount': cart.total * 100,
                                'name': 'XYZ Pvt Ltd.',
                                'external': {
                                  'wallets': [
                                    'paytm',
                                  ],
                                },
                              };
                              _razorpay.open(options);
                            },
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
              // Displaying Snacks items
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: _getFilteredProducts(snacksList).length,
                  itemBuilder: (context, index) {
                    final snacks = _getFilteredProducts(snacksList);
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(snacks[index]);
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
                            if (cart.cartProducts.contains(snacks[index])) {
                              cart
                                ..removeAll(snacks[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(snacks[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          title: Text(snacks[index].name),
                          subtitle: Text('\u{20B9}${snacks[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value: cart.cartProducts.contains(snacks[index]),
                            onChanged: (value) {
                              if (cart.cartProducts.contains(snacks[index])) {
                                cart
                                  ..removeAll(snacks[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(snacks[index])
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
                                        cart.removeItem(snacks[index]);
                                        if (!cart.cartProducts
                                            .contains(snacks[index])) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item == snacks[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(snacks[index])
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
              // Displaying beverage items
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: _getFilteredProducts(beverageList).length,
                  itemBuilder: (context, index) {
                    final beverages = _getFilteredProducts(beverageList);
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(beverages[index]);
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
                            if (cart.cartProducts.contains(beverages[index])) {
                              cart
                                ..removeAll(beverages[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(beverages[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          title: Text(beverages[index].name),
                          subtitle: Text('\u{20B9}${beverages[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value: cart.cartProducts.contains(beverages[index]),
                            onChanged: (value) {
                              if (cart.cartProducts
                                  .contains(beverages[index])) {
                                cart
                                  ..removeAll(beverages[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(beverages[index])
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
                                        cart.removeItem(beverages[index]);
                                        if (!cart.cartProducts
                                            .contains(beverages[index])) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item == beverages[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(beverages[index])
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
              // Displaying Chocolate and Candy items
              Padding(
                padding: cart.cartProducts.isNotEmpty
                    ? const EdgeInsets.only(bottom: 122)
                    : const EdgeInsets.only(bottom: 1),
                child: ListView.builder(
                  itemCount: _getFilteredProducts(chocoCandyList).length,
                  itemBuilder: (context, index) {
                    final chocoCandies = _getFilteredProducts(chocoCandyList);
                    final itemAlreadyInCart =
                        cart.cartProducts.contains(chocoCandies[index]);
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
                                .contains(chocoCandies[index])) {
                              cart
                                ..removeAll(chocoCandies[index])
                                ..decreaseItemCount()
                                ..calculateTotal();
                            } else {
                              cart
                                ..addItem(chocoCandies[index])
                                ..increaseItemCount()
                                ..calculateTotal();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 1.4),
                          ),
                          title: Text(chocoCandies[index].name),
                          subtitle:
                              Text('\u{20B9}${chocoCandies[index].price}'),
                          leading: Checkbox(
                            activeColor: Colors.blue.shade500,
                            shape: const CircleBorder(),
                            value:
                                cart.cartProducts.contains(chocoCandies[index]),
                            onChanged: (value) {
                              if (cart.cartProducts
                                  .contains(chocoCandies[index])) {
                                cart
                                  ..removeAll(chocoCandies[index])
                                  ..decreaseItemCount()
                                  ..calculateTotal();
                              } else {
                                cart
                                  ..addItem(chocoCandies[index])
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
                                        cart.removeItem(chocoCandies[index]);
                                        if (!cart.cartProducts
                                            .contains(chocoCandies[index])) {
                                          cart.decreaseItemCount();
                                        }
                                        cart.calculateTotal();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cart.cartProducts
                                          .where((item) {
                                            return item == chocoCandies[index];
                                          })
                                          .length
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart
                                          ..addItem(chocoCandies[index])
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
