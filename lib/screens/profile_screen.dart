import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitchen_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ super.key});
  

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Declarations
  Future<void> logOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (error) {
      debugPrint('Error signing out: $error');
    }
  }

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
                backgroundImage: NetworkImage(
                    'https://a0.anyrgb.com/pngimg/1912/680/icon-user-profile-avatar-ico-facebook-user-head-black-icons-circle.png'),
                radius: 46,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          //User Name
         const Text(
             'User',
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
              logOut().then(
                (value) => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => LogInScreen(),
                  ),
                  (route) => false,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
