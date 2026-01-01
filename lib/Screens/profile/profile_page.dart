import 'package:e_commerce_app/Screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final userBox = Hive.box('userBox');

  @override
  void initState() {
    super.initState();
    nameController.text = userBox.get('name', defaultValue: '');
    emailController.text = userBox.get('email', defaultValue: '');
  }

  void updateProfile() {
    userBox.put('name', nameController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  void logout() {
    userBox.clear(); // Clear session
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Email (Read-only)
            TextField(
              controller: emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // Update Profile Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: updateProfile,
                child: const Text('Update Profile'),
              ),
            ),

            const SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
