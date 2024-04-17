import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kitchen_app/model/user.dart';
import 'package:kitchen_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({required this.user, super.key});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user!.name,
              style: TextStyle(fontSize: 25),
            ),
            accountEmail: Text(user!.email),
            decoration: BoxDecoration(color: Colors.red),
          ),
          //Payment history
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 19,
              child: Icon(
                Icons.payment,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            title: const Text(
              'Payment History',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(
            thickness: 2,
          ),
          //Raise a request
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 19,
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            title: const Text(
              'Raise a Request',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(
            thickness: 2,
          ),
          //Logout
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 19,
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              showDialog<dynamic>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alert..!!'),
                    content: const Text("Are you sure to logout"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', false);
                          unawaited(
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute<dynamic>(
                                builder: (context) => const LogInScreen(),
                              ),
                              (route) => false,
                            ),
                          );
                        },
                        child: const Text('yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('no'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
