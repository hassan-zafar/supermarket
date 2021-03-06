import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/Screens/feeds.dart';

import 'Providers/provider/bottom_navigation_bar_provider.dart';
import 'Screens/adminScreens/allUsers.dart';
import 'Screens/adminScreens/chatLists.dart';
import 'Screens/cart/cart.dart';
import 'Screens/search.dart';
import 'Screens/user_info.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List<Widget> pages = <Widget>[
    Feeds(),
    Search(),
    // CartScreen(),
    // CalenderScreen(),
    UserInfoScreen(),
    // UserNSearch(),
    // ChatLists(),
    // UploadProductForm()
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarProvider _page =
        Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: pages[_page.selectedPage],
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (int updatedPage) => _page.updateSelectedPage(updatedPage),
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey.shade700,
          selectedItemColor: Colors.black,
          currentIndex: _page.selectedPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.shopping_cart_rounded),
            //   label: 'Cart',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.calendar_today),
            //   label: 'All Bookings',
            // ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'User Info'),

            // admin screen
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.people),
            //   label: 'All Users',
            // ),

            // admin screen
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat_bubble),
            //   label: 'Admin Chats',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.upload),
            //   label: 'Upload Product',
            // ),
          ],
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Icon(_userTileIcons[index]),
    );
  }

  Widget userTitle({required String title, Color color: Colors.yellow}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
      ),
    );
  }
}
