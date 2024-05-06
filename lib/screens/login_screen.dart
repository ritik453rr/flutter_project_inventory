import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kitchen_app/model/user.dart';
import 'package:kitchen_app/screens/products_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  //declarations......
  bool visibility = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static List<User> users = [
    User(
        name: "Ritik",
        id: 21120009,
        password: "Ritik@123",
        mob: 9690302137,
        email: "dritik458@gmail.com"),
    User(
        name: "Vishal",
        id: 21120008,
        password: "Vishal@123",
        mob: 8077885544,
        email: "vishal55@gmail.com"),
    User(
        name: "Shivek",
        id: 21120001,
        password: "Shivek@123",
        mob: 9988776655,
        email: "shivek@gmail.com"),
    User(
      name: "Prince",
      id: 21120003,
      password: "Prince@123",
      mob: 9877554433,
      email: 'prince5@gmail.com',
    ),
  ];
  late User currentUser;
  bool userExist() {
    for (final i in users) {
      if (i.id.toString() == userIdController.text &&
          i.password == passwordController.text) {
        currentUser = i;
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.16,
              ),
              //Login text
              Text(
                'Login',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //Login to your account text
              Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      //user id field
                      TextFormField(
                        controller: userIdController,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "enter user id";
                          }
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'User ID',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.03,
                      ),
                      //password field
                      TextFormField(
                        controller: passwordController,
                        obscureText: visibility,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "enter password";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visibility = !visibility;
                              });
                            },
                            icon: visibility == true
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              //Login Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.width * 0.14,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (userExist()) {
                        unawaited(
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (context) => const ProductsScreen(),
                            ),
                            (route) => false,
                          ),
                        );
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString('userId', userIdController.text);
                      } else {
                        unawaited(
                          showDialog<dynamic>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Warning"),
                                content: const Text("Invalid id or password"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("ok"),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              //Login Image
              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/userlog.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
