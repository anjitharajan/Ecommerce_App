import 'package:e_commerce_app/Screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';



class SignupPage extends StatefulWidget {
   SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  //------- Controllers for sgnup fields -------\\
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

//------- Loading State -------\\
  bool isLoading = false;

//------- Signup Function -------\\
  Future<void> signupUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      // ------Firebase Signup-------\\
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //-------- Save user data locally using Hive (Local NoSQL DB)-------\\
      final userBox = Hive.box('userBox');
      userBox.put('isLoggedIn', true);
      userBox.put('name', nameController.text.trim());
      userBox.put('email', emailController.text.trim());

      //-----Navigate to Home-------\\
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomePage()),
      );
    }

    //------- Handle Signup Errors -------\\
     on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Signup failed')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(height: 30),

              //---- Name----\\
              TextField(
                controller: nameController,
                decoration:  InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 20),

              //----Email----\\
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 20),

              //-----Password-----\\
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration:  InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

               SizedBox(height: 30),

              //-----Signup Button-----\\
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : signupUser,
                  child: isLoading
                      ?  CircularProgressIndicator(color: Colors.white)
                      :  Text('Create Account'),
                ),
              ),

               SizedBox(height: 20),

              //-----Back to Login-----\\
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:  Text('Already have an account? Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
