import 'package:flutter/material.dart';
import 'package:mypfe/constants/greeting.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/utilities/dialogs/logout_dialog.dart';
import 'package:mypfe/views/adminView/settings/settings_view.dart';
import 'package:mypfe/views/adminView/stations/station_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:developer' as devtools show log;
import '../../enums/menu_action.dart';
import 'admin/admins_view.dart';
import 'companies/companies_view.dart';
import 'home/admin_home_page.dart';

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AdminHomeView(),
    CompanyView(),
    StationView(),
    AdminsView(),
    SettingsView(),
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
        elevation: 2,
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
                    'log out',
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 68, 239),
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
              color: Color.fromARGB(255, 113, 68, 239),
            ),
            title: const Text("Home"),
          ),
          //Train
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.business,
            ),
            title: const Text("Compagnies"),
          ),
          //Tickets
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.traffic_sharp,
            ),
            title: const Text("Stations"),
          ),
          //Stations
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.person_4_outlined,
            ),
            title: const Text("Admins"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.settings,
              
            ),
            title: const Text("Settings"),
          ),
        ],
        
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedColorOpacity: 0.2,
      ),
    );
  }
}


// bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.business),
      //       label: 'Companies',
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.traffic_sharp),
      //       label: 'Stations',
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.person_4_outlined),
      //       label: 'Admins',
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.settings),
      //       label: 'Settings',
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: const Color.fromARGB(255, 71, 176, 237),
      //   onTap: _onItemTapped,
      // ),