import 'package:flutter/material.dart';
import 'package:kitchen_app/model/product.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/provider/selected_item.dart';
import 'package:kitchen_app/screens/drawar_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //instance of razorpay
  final _razorpay = Razorpay();
  //List of all Products
  List<Product> productList = [
    Product(id: 1, name: 'Pepsi (100ml)', price: 20),
    Product(id: 2, name: 'Lays', price: 15),
    Product(id: 3, name: 'Takatak', price: 10),
    Product(id: 4, name: 'Coconut Biscuit', price: 10),
    Product(id: 5, name: 'Parle G', price: 10),
    Product(id: 6, name: 'Dairy Milk', price: 20),
    Product(id: 7, name: 'Kurkure', price: 10),
    Product(id: 8, name: 'Chips', price: 50),
    Product(id: 9, name: 'Sprite', price: 20),
    Product(id: 10, name: 'Pringles', price: 50),
    Product(id: 11, name: 'Sandwich', price: 25),
    Product(id: 12, name: 'Kitkat', price: 10),
    Product(id: 13, name: 'Punjabi Tadka', price: 10),
  ];
  //List to store products
  List<Product> foundProduct = [];
  //Function to display searched Product
  void runFilter(String enteredKeyword) {
    var results = <Product>[];
    if (enteredKeyword.isNotEmpty) {
      for (final item in productList) {
        if (item.name.toLowerCase().startsWith(enteredKeyword.toLowerCase())) {
          results.add(item);
        }
      }
    } else {
      results = productList;
    }
    setState(() {
      foundProduct = results;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void initState() {
    foundProduct = productList;
    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerScreen(),
        //Bottomsheet
        bottomSheet: cart.cartProducts.isNotEmpty
            ? Container(
                width: double.infinity,
                height: 110,
                color: Colors.white,
                child: Consumer<SelectedItemIndex>(
                  builder: (context, selectedIndex, child) => Column(
                    children: [
                      //Item count
                      Text(
                        'Items:${cart.itemCount}',
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      //Total
                      Text(
                        'Total:${cart.total}',
                        style: const TextStyle(fontSize: 17),
                      ),
                      //Continue to payment button
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
                            //Styling on continue to payment button
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
                ),
              )
            : const Text(''),
        appBar: AppBar(
          title: const Text('Inventory', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          surfaceTintColor: Colors.blue.shade700,
        ),
        body: Column(
          children: [
            Container(
              height: 115,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                    child: SizedBox(
                      height: 60,
                      //Seach Product field
                      child: TextField(
                        onChanged: runFilter,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1.4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1.4),
                          ),
                          hintText: 'Search Product',
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: foundProduct.isEmpty
                        ? const Text(
                            ' ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Text(
                            'Select the Product of your choice.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: foundProduct.isNotEmpty
                  ? Padding(
                      padding: cart.cartProducts.isNotEmpty
                          ? const EdgeInsets.only(bottom: 110)
                          : const EdgeInsets.only(bottom: 1),
                      child: ListView.builder(
                        itemCount: foundProduct.length,
                        itemBuilder: (context, index) {
                          final itemAlreadyInCart =
                              cart.cartProducts.contains(foundProduct[index]);
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              left: 9,
                              right: 9,
                            ),
                            child: SizedBox(
                              height: 70,
                              child: ListTile(
                                tileColor: Colors.black12,
                                onTap: () {
                                  if (cart.cartProducts
                                      .contains(foundProduct[index])) {
                                    cart
                                      ..removeAll(foundProduct[index])
                                      ..decreaseItemCount()
                                      ..calculateTotal();
                                  } else {
                                    cart
                                      ..addItem(foundProduct[index])
                                      ..increaseItemCount()
                                      ..calculateTotal();
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(width: 1.4),
                                ),
                                //Tilte
                                title: Text(
                                  foundProduct[index].name,
                                ),
                                //Subtitle
                                subtitle: Text(
                                  '\u{20B9}${foundProduct[index].price}',
                                ),
                                //Checkbox
                                leading: Checkbox(
                                  activeColor: Colors.blue.shade500,
                                  shape: const CircleBorder(),
                                  value: cart.cartProducts
                                      .contains(foundProduct[index]),
                                  onChanged: (value) {
                                    if (cart.cartProducts
                                        .contains(foundProduct[index])) {
                                      cart
                                        ..removeAll(foundProduct[index])
                                        ..decreaseItemCount()
                                        ..calculateTotal();
                                    } else {
                                      cart
                                        ..addItem(foundProduct[index])
                                        ..increaseItemCount()
                                        ..calculateTotal();
                                    }
                                  },
                                ),
                                //Remove and Add icon
                                trailing: itemAlreadyInCart
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //remove the item from cart
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              cart.removeItem(
                                                foundProduct[index],
                                              );
                                              if (!cart.cartProducts.contains(
                                                foundProduct[index],
                                              )) {
                                                cart.decreaseItemCount();
                                              }
                                              cart.calculateTotal();
                                            },
                                          ),
                                          //Quantity
                                          Text(
                                            cart.cartProducts
                                                .where((item) {
                                                  return item ==
                                                      foundProduct[index];
                                                })
                                                .length
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          //Add icon button
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              cart
                                                ..addItem(foundProduct[index])
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
                    )
                  : const Text('No result found'),
            ),
          ],
        ),
      ),
    );
  }
}
