import 'package:flutter/material.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/ui/screens/home/bottom_nav_list.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  int _selectedIndex = 0;
  String appTitle = StringResources.tab1;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //region bottom nav item tap call back function
  _onItemTapped(int index) {
    setState(() {
      widget._selectedIndex = index;
      if (index == 0) {
        widget.appTitle = StringResources.tab1;
      } else if (index == 1) {
        widget.appTitle = StringResources.tab2;
      } else if (index == 2) {
        widget.appTitle = StringResources.tab3;
      } else if (index == 3) {
        widget.appTitle = StringResources.tab4;
      } else if (index == 4) {
        widget.appTitle = StringResources.tab5;
      }
    });
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.appTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: ColorResources.darkGreyColor,
            fontFamily: FontResources.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: bottomNavList.elementAt(widget._selectedIndex),
      //region bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_rounded),
            label: StringResources.tab1,
            backgroundColor: ColorResources.smokeWhiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: StringResources.tab2,
            backgroundColor: ColorResources.smokeWhiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: StringResources.tab3,
            backgroundColor: ColorResources.smokeWhiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: StringResources.tab4,
            backgroundColor: ColorResources.smokeWhiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: StringResources.tab5,
            backgroundColor: ColorResources.smokeWhiteColor,
          )
        ],
        iconSize: 24.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: ColorResources.smokeWhiteColor,
        selectedItemColor: ColorResources.darkGreyColor,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          color: ColorResources.darkGreyColor,
          fontFamily: FontResources.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          color: ColorResources.lightGreyColor,
          fontFamily: FontResources.bold,
        ),
        unselectedItemColor: ColorResources.lightGreyColor,
        currentIndex: widget._selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      //endregion
    );
  }
}
