import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_pack/common_widgets/app_text.dart';
import 'package:grocery_pack/models/category_item.dart';
import 'package:grocery_pack/screens/account/account_screen.dart';
import 'package:grocery_pack/screens/cart/cart_screen.dart';
import 'package:grocery_pack/screens/category_items_screen.dart';
import 'package:grocery_pack/screens/favourite_screen.dart';
import 'package:grocery_pack/screens/home/home_screen.dart';
import 'package:grocery_pack/widgets/category_item_card_widget.dart';
import 'package:grocery_pack/widgets/search_bar_widget.dart';

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
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
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        selectedItemColor: Colors.green, // Set the color to green for the selected icon
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.green : Colors.grey, // Change color conditionally
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: _currentIndex == 1 ? Colors.green : Colors.grey, // Change color conditionally
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _currentIndex == 2 ? Colors.green : Colors.grey, // Change color conditionally
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _currentIndex == 3 ? Colors.green : Colors.grey, // Change color conditionally
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 4 ? Colors.green : Colors.grey, // Change color conditionally
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            getHeader(),
            Expanded(
              child: getStaggeredGridView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: AppText(
            text: "Find Products",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SearchBarWidget(),
        ),
      ],
    );
  }

  Widget getStaggeredGridView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: categoryItemsDemo.asMap().entries.map<Widget>((e) {
          int index = e.key;
          CategoryItem categoryItem = e.value;
          return GestureDetector(
            onTap: () {
              onCategoryItemClicked(context, categoryItem);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: CategoryItemCardWidget(
                item: categoryItem,
                color: gridColors[index % gridColors.length],
              ),
            ),
          );
        }).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0, // add some space
      ),
    );
  }

  void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CategoryItemsScreen();
        },
      ),
    );
  }
}
