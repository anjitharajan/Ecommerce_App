import 'dart:async';
import 'package:flutter/material.dart';
import '../product/product_list_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //-----5 minute countdown-----\\
  int remainingSeconds = 300; 
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

//------- Countdown Timer -------\\
  void startCountdown() {
    timer = Timer.periodic( Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer?.cancel();
      }
    });
  }

//------- Dispose Timer -------\\
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  String get timeText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('E-Commerce'),
        actions: [
          IconButton(
            icon:  Icon(Icons.shopping_cart),

            //------- Navigate to Cart Page -------\\
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  CartPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //------ Banner -------\\
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Center(
                  child: Text(
                    'Big Sale!\nUp to 50% OFF',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

               SizedBox(height: 20),

              //----- Limited Time Offer-------\\
              Container(
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Limited Time Offer',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timeText,
                      style:  TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 20),

              //----- Categories -------\\
               Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

               SizedBox(height: 10),

             //------- Category List -------\\
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryChip('Electronics'),
                    categoryChip('Jewelery'),
                    categoryChip('Men'),
                    categoryChip('Women'),
                  ],
                ),
              ),

               SizedBox(height: 30),

              //------- Featured Products-------\\
               Text(
                'Featured Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

               SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                //------ View Products -------\\
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  ProductListPage()),
                    );
                  },
                  child:  Text('View Products'),
                ),
              ),

               SizedBox(height: 20),

              //---- Profile----\\
              SizedBox(
                width: double.infinity,
                height: 50,
                //------ My Profile Navigation -------\\
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  ProfilePage()),
                    );
                  },
                  child:  Text('My Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//------- Category Chip Widget -------\\
  Widget categoryChip(String title) {
    return Container(
      margin:  EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(title),
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}
