import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitchen_app/model/user.dart';
import 'package:kitchen_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final Uri _url = Uri.parse(
    'https://docs.google.com/forms/d/e/1FAIpQLSfWwH9NgG6YKyFwK8SGgNzsxylno4Ymlwtql0MMwjbqlgpvaQ/viewform?usp=sf_link',
  );
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
            decoration: BoxDecoration(color: Colors.blue.shade700),
          ),
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
            onTap: _launchUrl,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                        child: const Text(
                          'yes',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'no',
                          style: TextStyle(color: Colors.blue),
                        ),
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
