import 'package:flutter/material.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/ui/views/dashboard_view.dart';
import 'package:sru/ui/views/orderjual/orderjual.dart';
// import 'package:sru/ui/views/pengiriman/list_pengiriman_owner.dart';

class NavbarOwnerView extends StatefulWidget {
  const NavbarOwnerView({super.key});

  @override
  State<NavbarOwnerView> createState() => _NavbarOwnerViewState();
}

class _NavbarOwnerViewState extends State<NavbarOwnerView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    Text(
      'Index 1: Business',
    ),
    OrderJualView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Sales',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Katalog',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: sruColor.navbarSelectedColor,
            unselectedItemColor: sruColor.navbarUnselectedColor,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 5.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            ),
          )
        ],
      ),
    );
  }
}
