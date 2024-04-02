import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/provider/selected_item.dart';
import 'package:kitchen_app/screens/products_screen.dart';
import 'package:kitchen_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});


  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //initialized selectedItemIndex with 0
  // int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedItemIndex>(
      builder: (context, selectedItemIndex, child) => Scaffold(
        bottomNavigationBar: Consumer<Cart>(
          builder: (context, cart, child) => BottomNavigationBar(
            currentIndex: selectedItemIndex.selectedNavIndex,
            selectedItemColor: Colors.blue.shade500,
            items: const <BottomNavigationBarItem>[
              //All Products
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'All Products',
              ),
              //Profile
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            //onTap...
            onTap: (index) {
              if (index == 0) {
                selectedItemIndex.allProduct();
              }
              if (index == 1) {
                selectedItemIndex.profile();
                cart.checkOut();
              }
            },
          ),
        ),
        body: selectedItemIndex.selectedNavIndex == 1
            ? const ProfileScreen()
            : const ProductsScreen(),
      ),
    );
  }
}
