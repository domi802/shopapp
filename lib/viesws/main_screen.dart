import 'package:flutter/material.dart';
import 'package:shopapp/viesws/account_screen.dart';
import 'package:shopapp/viesws/cart_screen.dart';
import 'package:shopapp/viesws/favorite_screen.dart';
import 'package:shopapp/viesws/home_screen.dart';
import 'package:shopapp/viesws/stores_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    StoresScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/icons/home.png",
                  width: 25,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/icons/love.png",
                  width: 25,
                ),
                label: "Favorite"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/icons/mart.png",
                  width: 25,
                ),
                label: "Store"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/icons/cart.png",
                  width: 25,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/assets/icons/user.png",
                  width: 25,
                ),
                label: "Account"),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
