import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/enums/menu_action.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/utilities/dialogs/logout_dialog.dart';
import 'package:mypfe/widgets/booking/hello_client.dart';
import 'package:mypfe/widgets/booking/hotel_list.dart';
import 'dart:developer' as devtools show log;

import 'package:mypfe/widgets/booking/search_ticket.dart';

final formatter = DateFormat.yMMMd();

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  String get userEmail => AuthService.firebase().currentUser!.email;
  String? _selectedDate;
  late final String _selectedFromStation;
  late final String _selectedToStation;

  // void _startAddPassengers(BuildContext context){
  //   showBottomSheet(context: context, builder: (context){
  //     return PassengerPicker();
  //   });
  // }

  @override
  void initState() {
    _selectedFromStation = "";
    _selectedToStation = "";
    super.initState();
  }

  void _afficheCalendrier() async {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, now.day + 2);
    final last = DateTime(now.year, now.month + 1, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: first,
      lastDate: last,
    );
    setState(() {
      _selectedDate = formatter.format(pickedDate!);
    });
  }

  void _swapStations() {
    var temp = _selectedFromStation;
    setState(() {
      _selectedFromStation = _selectedToStation;
      _selectedToStation = temp;
    });
  }

  String _getInitials(String user) => user.isNotEmpty
      ? user.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.1,
            actions: [
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
            ],
            flexibleSpace: const FlexibleSpaceBar(
              stretchModes: [StretchMode.fadeTitle],
              background: HelloClient(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: SearchTicket(
                  selectedFromStation: _selectedFromStation,
                  selectedToStation: _selectedToStation,
                  showCalendar: _afficheCalendrier,
                  swap: _swapStations,
                  search: () async {
                    final depart = _selectedFromStation;
                    final arrivee = _selectedToStation;
                    if (_selectedDate != null) {
                      Navigator.of(context)
                          .pushNamed(ticketsResultsRoute, arguments: [
                        depart,
                        arrivee,
                        _selectedDate!,
                      ]);
                    } else {
                      return await showErrorDialog(
                          context, 'Veuillez remplir tous les champs.');
                    }
                  },
                  selectedDate: _selectedDate,
                  nbrPassengers: () {},
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 10.0),
            sliver: SliverToBoxAdapter(
              child: HotelList(),
            ),
          ),
        ],
      ),
    );
  }
}
