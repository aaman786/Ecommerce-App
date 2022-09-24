import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/screens/acc_screen.dart';
import 'package:amazone_clone/features/cart/screens/cart_screen.dart';
import 'package:amazone_clone/provider/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/home/screens/home_screen.dart';

class CustomBottomBar extends StatefulWidget {
  static const String routeName = '/customBottomBar';
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _page = 0;
  double navBarWidth = 42;
  double navBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: navBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: navBorderWidth)),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Container(
                width: navBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: navBorderWidth)),
                ),
                child: const Icon(Icons.person_outline),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Container(
                  width: navBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: navBorderWidth)),
                  ),
                  child: Badge(
                      elevation: 0,
                      badgeContent: Text(userCartLength.toString()),
                      badgeColor: Colors.white,
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                      ))),
              label: "Cart"),
        ],
      ),
    );
  }
}
