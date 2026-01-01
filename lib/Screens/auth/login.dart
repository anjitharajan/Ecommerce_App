import 'package:e_commerce_app/Screens/auth/signup.dart';
import 'package:e_commerce_app/Screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';



class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //----- Text Controllers for email and password -----\\
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

//----- Loading State -----\\
  bool isLoading = false;

//----- Login User Function -----\\
  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      //-----Firebase Login -----\\
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //------Saving session locally using Hive -----\\
      final userBox = Hive.box('userBox');
      userBox.put('isLoggedIn', true);
      userBox.put('email', emailController.text.trim());

      //-------Navigate to Homepage------\\
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomePage()),
      );
    } 
    
    //----- Error Handling -----\\
    on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
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
        title:  Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [
             SizedBox(height: 40),

            //-------Email--------\\
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

             SizedBox(height: 20),

            //--------Password--------\\
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

             SizedBox(height: 30),

            //------Login Button -------\\
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : loginUser,
                child: isLoading
                    ?  CircularProgressIndicator(color: Colors.white)
                    :  Text('Login'),
              ),
            ),

             SizedBox(height: 20),

            //-------Navigate to Signup--------\\
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  SignupPage()),
                    );
                  },
                  child:  Text('Sign Up'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
