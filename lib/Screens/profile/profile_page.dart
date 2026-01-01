import 'package:e_commerce_app/Screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //------- Controllers for Profile Fields -------\\
  final nameController = TextEditingController();
  final emailController = TextEditingController();

// ------ Hive User Box -------\\
  final userBox = Hive.box('userBox');

  @override

  //------- Initialize Profile Data -------\\
  void initState() {
    super.initState();
    nameController.text = userBox.get('name', defaultValue: '');
    emailController.text = userBox.get('email', defaultValue: '');
  }

//------- Update Profile Function -------\\
  void updateProfile() {
    userBox.put('name', nameController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Profile updated successfully')),
    );
  }

//------- Logout Function -------\\
  void logout() {
    userBox.clear(); //<<<-----Clear session-----\\
    Navigator.pushAndRemoveUntil(

      //------- Navigate to Login Page -------\\
      context,
      MaterialPageRoute(builder: (_) =>  LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Profile'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [
             SizedBox(height: 20),

            //----Name----\\
            TextField(
              controller: nameController,
              decoration:  InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),

             SizedBox(height: 20),

            //-----Email-----\\
            TextField(
              controller: emailController,
              readOnly: true,
              decoration:  InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

             SizedBox(height: 30),

            //------Update Profile Button-------\\
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: updateProfile,
                child:  Text('Update Profile'),
              ),
            ),

             SizedBox(height: 20),

            //-----Logout Button-----\\
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: logout,
                child:  Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
