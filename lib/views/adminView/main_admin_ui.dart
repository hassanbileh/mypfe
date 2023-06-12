import 'package:flutter/material.dart';
import 'package:mypfe/constants/greeting.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/utilities/dialogs/logout_dialog.dart';
import 'dart:developer' as devtools show log;
import '../../enums/menu_action.dart';

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Companies',
      style: optionStyle,
    ),
    Text(
      'Index 2: Stations',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
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
        title: Text(greeting()),
        actions: [
          //? PopupMenuButton
          //? on crée d'abord le MenuAction enum et on l'utilise dans PopMenuButton
          PopupMenuButton<MenuAction>(
            color: Colors.black.withOpacity(0.5),
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
                case MenuAction.addAdmin:
                  // Show add admin form
                  Navigator.of(context).pushNamed(
                    createOrUpdateAdmin,
                  );
                case MenuAction.addStation:
                  // Show add station form
                  Navigator.of(context).pushNamed(
                    createOrUpdateAdmin,
                  );

                case MenuAction.addCompany:
                  // Show add campany form
                  Navigator.of(context).pushNamed(
                    createOrUpdateCompany,
                  );

                default:
              }
            },

            // Menu Action builder
            itemBuilder: (value) {
              return [
                //? Popup du menuItem
                //? add admin
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.addAdmin,
                  child: Text(
                    'add admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const PopupMenuItem<MenuAction>(
                  value: MenuAction.addStation,
                  child: Text(
                    'add station',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const PopupMenuItem<MenuAction>(
                  value: MenuAction.addCompany,
                  child: Text(
                    'add company',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text(
                    'log out',
                    style: TextStyle(
                      color: Colors.white,
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business),
            label: 'Companies',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.traffic_sharp),
            label: 'Stations',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 71, 176, 237),
        onTap: _onItemTapped,
      ),
    );
  }
}
