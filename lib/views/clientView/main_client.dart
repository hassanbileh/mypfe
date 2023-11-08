import 'package:flutter/material.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/views/clientView/bookingViews/home_page.dart';

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

  final Map<String, IconData> _icons = {
    'Home': Icons.home_filled,
    'Tickets': Icons.confirmation_num,
    'Settings': Icons.settings,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: _icons
            .map(
              (title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30.0,
                  ),
                  label: title,
                ),
              ),
            )
            .values
            .toList(),
        currentIndex: _selectedIndex,
        selectedFontSize: 11.0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
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