import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitchen_app/model/user.dart';
import 'package:kitchen_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({ super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}
class _NavBarState extends State<NavBar> {
  String? currentUserId;
  User? currentUser;
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });

    for (final i in LogInScreenState.users) {
      if (i.id.toString() == currentUserId) {
        setState(() {
          currentUser = i;
        });
      }
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              currentUser!.name,
              style: const TextStyle(fontSize: 25),
            ),
            accountEmail: Text(
              currentUser!.email,
            ),
            decoration: const BoxDecoration(color: Colors.redAccent),
          ),
          //Payment history
          // ListTile(
          //   leading: const CircleAvatar(
          //     backgroundColor: Colors.black54,
          //     radius: 19,
          //     child: Icon(
          //       Icons.payment,
          //       color: Colors.white,
          //     ),
          //   ),
          //   trailing: const Icon(Icons.keyboard_arrow_right),
          //   title: const Text(
          //     'Payment History',
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onTap: () {},
          // ),
          // const SizedBox(
          //   height: 6,
          // ),
          // const Divider(
          //   thickness: 2,
          // ),
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
