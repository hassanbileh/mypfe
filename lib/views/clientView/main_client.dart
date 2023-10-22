import 'package:flutter/material.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/views/clientView/bookingViews/home_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class MainClientPage extends StatefulWidget {
  const MainClientPage({super.key});

  @override
  State<MainClientPage> createState() => _MainClientPageState();
}

class _MainClientPageState extends State<MainClientPage> {
  int _selectedIndex = 0;
  String get compEmail => AuthService.firebase().currentUser!.email;
  static const List<Widget> _widgetOptions = <Widget>[
    ClientHomePage(),
    Scaffold(body: Center(child: Text('Recherche Ticket Page'))),
    Text('Profil Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: const Color.fromARGB(255, 113, 68, 239),
          items: [
            //Home
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.search_rounded,
              ),
              title: const Text("Recherche"),
            ),
            //Tickets
            SalomonBottomBarItem(
              activeIcon: const Icon(Icons.confirmation_num_rounded),
              icon: const Icon(Icons.confirmation_num_outlined),
              title: const Text("Tickets"),
            ),
            //Stations
            SalomonBottomBarItem(
              activeIcon: const Icon(
                Icons.person,
              ),
              icon: const Icon(
                Icons.person_2_outlined,
              ),
              title: const Text("Profil"),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedColorOpacity: 0.2,
        ));
  }
}

// Logout 

/*
PopupMenuButton<MenuAction>(
              color: const Color.fromARGB(255, 74, 44, 156),
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
                    child: Row(
                      children: [
                        Text(
                          'Se deconnecter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          
*/