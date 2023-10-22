import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:intl/intl.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/tickets/form_ticket.dart';

final formatter = DateFormat.yMMMd();

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  String get compagnyEmail => AuthService.firebase().currentUser!.email;
  late final FirebaseCloudUserStorage _userService;
  late final FirebaseCloudTrainStorage _trainService;
  late final FirebaseCloudStationStorage _stationService;
  late final FirebaseCloudTicketStorage _ticketService;

  CloudTicket? _ticket;
  String? _selectedDate;
  String? _selectedDepartureTime;
  String? _selectedArrivalTime;
  String? _selectedTrain;
  String? _selectedFromStation;
  String? _selectedToStation;
  String get compagnieEmail => AuthService.firebase().currentUser!.email;
  bool? _status;

  @override
  void initState() {
    _userService = FirebaseCloudUserStorage();
    _ticketService = FirebaseCloudTicketStorage();
    _stationService = FirebaseCloudStationStorage();
    _trainService = FirebaseCloudTrainStorage();
    super.initState();
  }

  @override
  void dispose() {
    _saveTicketIfTextNotEmpty();

    super.dispose();
  }

  void _afficheCalendrier() async {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, now.day + 3);
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

  void _afficheDepartureHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      final localisations = MaterialLocalizations.of(context);
      final formattedDepartureTime = localisations.formatTimeOfDay(pickedTime!,
          alwaysUse24HourFormat: true);
      _selectedDepartureTime = formattedDepartureTime;
    });
  }

  void _afficheArrivalHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      final localisations = MaterialLocalizations.of(context);
      final formattedDepartureTime = localisations.formatTimeOfDay(pickedTime!,
          alwaysUse24HourFormat: true);
      _selectedArrivalTime = formattedDepartureTime;
    });
  }

  Future<CloudTicket> createOrUpdateTicket(BuildContext context) async {
    final widgetTicket = context.getArguments<CloudTicket>();

    if (widgetTicket != null) {
      _selectedFromStation = widgetTicket.depart;
      _selectedToStation = widgetTicket.destination;
      _selectedTrain = widgetTicket.trainNum;
      _selectedDate = widgetTicket.jour;
      _selectedDepartureTime = widgetTicket.heureDepart;
      _selectedArrivalTime = widgetTicket.heureArrive;
      _status = widgetTicket.status;
      return widgetTicket;
    }

    final existingTicket = _ticket;
    if (existingTicket != null) {
      return existingTicket;
    } else {
      final company = await _userService.getUserName(email: compagnieEmail);
      final newTicket = await _ticketService.createNewTicket(
        company: company!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        compagnieEmail: compagnieEmail,
      );
      Navigator.of(context).pop();
      return newTicket;
    }
  }

  void _saveTicketIfTextNotEmpty() async {
    final ticket = _ticket;
    if (ticket != null &&
        _selectedFromStation != null &&
        _selectedToStation != null &&
        _selectedDate != null &&
        _selectedTrain != null &&
        _selectedDepartureTime != null &&
        _selectedArrivalTime != null &&
        _status != null) {
      await _ticketService.updateTicket(
        documentId: ticket.documentId,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
      );
    }
  }

  void _textControllerListener() async {
    final ticket = _ticket;
    if (ticket != null) {
      await _ticketService.updateTicket(
        documentId: ticket.documentId,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
      );
    } else {
      return;
    }
  }

  void _submitTicketData() async {
    try {
      if (_selectedDate == null ||
          _selectedFromStation == null ||
          _selectedToStation == null ||
          _selectedTrain == null ||
          _selectedDepartureTime == null ||
          _selectedArrivalTime == null) {
        return showErrorDialog(context, 'Veuillez remplir tous les champs');
      }
      final ticket = _ticket;
      if (ticket != null) {
      await _ticketService.updateTicket(
        documentId: ticket.documentId,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
      );
      Navigator.of(context).pop();
    } else {
      final company = await _userService.getUserName(email: compagnieEmail);
      await _ticketService.createNewTicket(
        company: company!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        compagnieEmail: compagnieEmail,
      );
      Navigator.of(context).pop();
    }
     
    } catch (e) {
      throw CouldNotCreateTicketException();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createOrUpdateTicket(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.done:
            _saveTicketIfTextNotEmpty();
            return FormTicket(
              stationStream: _stationService.getAllStations(),
              onChangeFromStation: (value) {
                setState(() {
                  if (value != null) {
                    setState(() {
                      _selectedFromStation = value;
                    });
                  } else {
                    return;
                  }
                });
              },
              fromStationValue: _selectedFromStation,
              onChangeToStation: (value) {
                setState(() {
                  if (value != null) {
                    setState(() {
                      _selectedToStation = value;
                    });
                  } else {
                    return;
                  }
                });
              },
              toStationValue: _selectedToStation,
              trainStream: _trainService.getTrainsByCompany(
                  compagnieEmail: compagnieEmail),
              onChangeTrain: (value) {
                setState(() {
                  if (value != null) {
                    setState(() {
                      _selectedTrain = value;
                    });
                  } else {
                    return;
                  }
                });
              },
              trainValue: _selectedTrain,
              selectedDate: _selectedDate,
              onPressed: _afficheCalendrier,
              selectedDepartureTime: _selectedDepartureTime,
              onPressedDepartureTime: _afficheDepartureHorloge,
              selectedArrivalTime: _selectedArrivalTime,
              onPressedArrivalTime: _afficheArrivalHorloge,
              onPressedSwitch: (bool status) {
                if (!status) {
                  setState(() {
                    _status = false;
                  });
                } else {
                  setState(() {
                    _status = true;
                  });
                }
              },
              submitData: _submitTicketData,
            );
         
         default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}


