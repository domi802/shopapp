import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/vendor/views/auth/screens/bottomNavigationBar/earnings_screen.dart';
import 'package:shopapp/vendor/views/auth/screens/bottomNavigationBar/edit_product.screen.dart';
import 'package:shopapp/vendor/views/auth/screens/bottomNavigationBar/upload_product_screen.dart';
import 'package:shopapp/vendor/views/auth/screens/bottomNavigationBar/vendor_order_screen.dart';
import 'package:shopapp/vendor/views/auth/screens/bottomNavigationBar/vendor_profile_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int pageIndex = 0;
  final List<Widget> _pages = [
    EarningScreen(),
    UploadProductScreen(),
    VendorOrderScreen(),
    EditProductScreen(),
    VendorProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Earning',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
