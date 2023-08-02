import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import '../../../widgets/booking/search_ticket.dart';

final formatter = DateFormat.yMMMd();

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  String get userEmail => AuthService.firebase().currentUser!.email;
  String? _selectedDate;
  late final TextEditingController _selectedFromStation;
  late final TextEditingController _selectedToStation;

  @override
  void initState() {
    _selectedFromStation = TextEditingController();
    _selectedToStation = TextEditingController();
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
    var temp = _selectedFromStation.text.toString();
    setState(() {
      _selectedFromStation.text = _selectedToStation.text.toString();
      _selectedToStation.text = temp;
    });
  }

  String _getInitials(String user) => user.isNotEmpty
      ? user.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Où désirez-vous voyager ?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(
            height: 10.0,
          ),

          SearchTicket(
            selectedFromStation: _selectedFromStation,
            selectedToStation: _selectedToStation,
            showCalendar: _afficheCalendrier,
            swap: _swapStations,
            search: () async {
              final depart = _selectedFromStation.text.toString();
              final arrivee = _selectedToStation.text.toString();
              if (depart.isNotEmpty &&
                  arrivee.isNotEmpty &&
                  _selectedDate != null) {
                Navigator.of(context)
                    .pushNamed(ticketsResultsRoute, arguments: [
                  depart,
                  arrivee,
                  _selectedDate,
                ]);
              } else {
                return await showErrorDialog(
                    context, 'Veuillez remplir tous les champs.');
              }
            },
            selectedDate: _selectedDate,
          )
        ],
      ),
    );
  }
}

