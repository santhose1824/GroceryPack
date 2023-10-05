import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_pack/common_widgets/app_text.dart';
import 'package:grocery_pack/screens/account/account_screen.dart';
import 'package:grocery_pack/screens/cart/cart_screen.dart';
import 'package:grocery_pack/screens/explore_screen.dart';
import 'package:grocery_pack/screens/home/home_screen.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  int _currentIndex = 0;

  void _onItemTapped(int index) {
     setState(() {
      _currentIndex = index; // Update the _currentIndex here
    });
    // Use Navigator to navigate to the selected screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          // Define the screens for each navigation item
          final List<Widget> screens = [
            HomeScreen(), // Replace with the home screen widget
            ExploreScreen(), // Replace with the explore screen widget
            CartScreen(), // Replace with the cart screen widget
            FavouriteScreen(), // Replace with the favorite screen widget
            AccountScreen(), // Replace with the profile screen widget
          ];

          // Return the selected screen based on the index
          return screens[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: AppText(
            text: "No Favorite Items",
            fontWeight: FontWeight.w600,
            color: Color(0xFF7C7C7C),
          ),
        ),
      ),
    );
  }
}
