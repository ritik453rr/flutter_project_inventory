import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitchen_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.name, super.key});
  final String name;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 140),
            child: Center(
              //Profile picture
              child: CircleAvatar(
                backgroundImage: AssetImage('user.png'),
                radius: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          //User Name
          Text(
            widget.name,
            style: const TextStyle(fontSize: 21, color: Colors.black87),
          ),
          const SizedBox(
            height: 32,
          ),
          //Payment History
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 19,
              child: Icon(
                Icons.payment,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text(
              'Payment History',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(
            thickness: 2,
          ),
          //Raise a request
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 19,
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text(
              'Raise a Request',
              style: TextStyle(fontSize: 16),
            ),
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
