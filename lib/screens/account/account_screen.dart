import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_pack/common_widgets/app_text.dart';
import 'package:grocery_pack/helpers/column_with_seprator.dart';
import 'package:grocery_pack/screens/cart/cart_screen.dart';
import 'package:grocery_pack/screens/explore_screen.dart';
import 'package:grocery_pack/screens/favourite_screen.dart';
import 'package:grocery_pack/screens/home/home_screen.dart';
import 'package:grocery_pack/screens/login.dart';
import 'package:grocery_pack/screens/welcome_screen.dart';
import 'package:grocery_pack/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; 
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
    return SafeArea(
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading:
                      SizedBox(width: 65, height: 65, child: getImageHeader()),
                  title: AppText(
                    text: "Santhose H.M",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: AppText(
                    text: "santhosehm@gmail.com",
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems.map((e) {
                      return getAccountItemWidget(e);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                logoutButton(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () async{
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);

        // Navigate to the WelcomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
        },
      ),
    );
  }

  Widget getImageHeader() {
    return CircleAvatar(
      radius: 5.0,
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      child: Text(
        'S',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
