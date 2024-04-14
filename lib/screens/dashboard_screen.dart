import 'package:flutter/material.dart';
import 'package:kitchen_app/model/user.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:kitchen_app/provider/selected_item.dart';
import 'package:kitchen_app/screens/login_screen.dart';
import 'package:kitchen_app/screens/products_screen.dart';
import 'package:kitchen_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? currentUserId;
  String? currentUserName;
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });
    for (final i in LogInScreenState.users) {
      if (i.id.toString() == currentUserId) {
        setState(() {
          currentUserName = i.name;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedItemIndex>(
      builder: (context, selectedItemIndex, child) => Scaffold(
        bottomNavigationBar: Consumer<Cart>(
          builder: (context, cart, child) => BottomNavigationBar(
            currentIndex: selectedItemIndex.selectedNavIndex,
            selectedItemColor: Colors.blue.shade500,
            items: const [
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
            ? ProfileScreen(
                name: currentUserName ?? 'user',
              )
            : const ProductsScreen(),
      ),
    );
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }
}
