import 'package:flutter/material.dart';
import '../home/home_page.dart';

class OrderSuccessPage extends StatelessWidget {
   OrderSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //------- Disable Back Button -------\\
        automaticallyImplyLeading: false, 
        title:  Text('Order Success'),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
               SizedBox(height: 20),
               Text(
                'Your order has been placed!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 10),
               Text(
                'Thank you for shopping with us.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) =>  HomePage()),
                      (route) => false, //<<<----clears navigation stack----\\
                    );
                  },
                  child:  Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
