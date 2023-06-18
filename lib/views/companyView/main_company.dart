import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/utilities/dialogs/logout_dialog.dart';
import 'package:mypfe/views/companyView/stations/cmp_stations_view.dart';
import 'package:mypfe/views/companyView/trains/train_list_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:developer' as devtools show log;

import '../../constants/greeting.dart';
import '../../enums/menu_action.dart';

class MainCompanyPage extends StatefulWidget {
  const MainCompanyPage({super.key});

  @override
  State<MainCompanyPage> createState() => _MainCompanyPageState();
}

class _MainCompanyPageState extends State<MainCompanyPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Campagnie Home Page'),
    TrainView(),
    Text('Tickets Page'),
    CompanyStationView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            greeting(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            //? PopupMenuButton
            //? on crée d'abord le MenuAction enum et on l'utilise dans PopMenuButton
            PopupMenuButton<MenuAction>(
              color: Colors.white,
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    devtools.log(shouldLogout.toString());
                    if (shouldLogout) {
                      //? en cas de deconnexion
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                  default:
                }
              },

              // Menu Action builder
              itemBuilder: (value) {
                return [
                  //? Popup du menuItem
                  const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text(
                      'Se deconnecter',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: const Color.fromARGB(255, 113, 68, 239),
          items: [
            //Home
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.home_outlined,
              ),
              title: const Text("Home"),
            ),
            //Train
            SalomonBottomBarItem(
              icon: const Icon(Icons.train_outlined),
              title: const Text("Trains"),
            ),
            //Tickets
            SalomonBottomBarItem(
              icon: const Icon(Icons.confirmation_num_rounded),
              title: const Text("Tickets"),
            ),
            //Stations
            SalomonBottomBarItem(
              icon: const Icon(Icons.traffic_sharp,),
              title: const Text("Stations"),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedColorOpacity: 0.2,
        ));
  }
}

