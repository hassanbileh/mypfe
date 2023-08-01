import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/widgets/station/add_station_form.dart';

class CreateOrUpdateStation extends StatefulWidget {
  final CloudStation? station;
  const CreateOrUpdateStation({super.key, required this.station});

  @override
  State<CreateOrUpdateStation> createState() => _CreateOrUpdateStationState();
}

class _CreateOrUpdateStationState extends State<CreateOrUpdateStation> {
  CloudStation? _station;
  late final FirebaseCloudStationStorage _stationService;
  late final TextEditingController _numero;
  late final TextEditingController _nom;
  late final TextEditingController _ville;

  @override
  void initState() {
    _stationService = FirebaseCloudStationStorage();
    _numero = TextEditingController();
    _nom = TextEditingController();
    _ville = TextEditingController();
    super.initState();
  }

  Future<CloudStation> createOrUpdateStation(BuildContext context) async {
    // final widgetStation2 = context.getArguments<CloudStation>();
    final widgetStation = widget.station;
    if (widgetStation != null) {
      _station = widgetStation;
      _numero.text = widgetStation.numero;
      _nom.text = widgetStation.nom;
      _ville.text = widgetStation.ville;
      return widgetStation;
    }

    final existingStation = _station;
    if (existingStation != null) {
      return existingStation;
    } else {
      final user = AuthService.firebase().currentUser;
      final adminEmail = user?.email;
      final newStation =
          await _stationService.createNewStation(adminEmail: adminEmail!);
      _station = newStation;

      return newStation;
    }
  }

// fonction qui ecoute et enregistre la station
//instantannement que l'utilisateur tape sur le clavier
  void _textControllerListener() async {
    final station = _station;
    if (station != null) {
      final numero = _numero.text.trim();
      final nom = _nom.text.trim();
      final ville = _ville.text.trim();
      await _stationService.updateStation(
        documentId: station.documentId,
        numero: numero,
        nom: nom,
        ville: ville,
      );
    } else {
      return;
    }
  }

  void _setUpTextControllerListener() {
    _numero.removeListener(_textControllerListener);
    _nom.removeListener(_textControllerListener);
    _ville.removeListener(_textControllerListener);
    _numero.addListener(_textControllerListener);
    _nom.addListener(_textControllerListener);
    _ville.addListener(_textControllerListener);
  }

// Fonction qui supprime la station
//si elle est vide lorsque le btton retour est touché
  void _deleteNoteIfTextIsEmpty() async {
    final station = _station;
    if (_numero.text.isEmpty ||
        _nom.text.isEmpty ||
        _ville.text.isEmpty && station != null) {
      await _stationService.deleteStation(documentId: station!.documentId);
    } else {
      throw CouldNotDeleteStationException();
    }
  }

  // Fonction qui enregistre la station
  //si elle n'est pas vide lorsque le btton retour est touché
  void _saveNoteIfTextNotEmpty() async {
    final station = _station;
    final numero = _numero.text.trim();
    final nom = _nom.text.trim();
    final ville = _ville.text.trim();

    if (station != null &&
        numero.isNotEmpty &&
        nom.isNotEmpty &&
        ville.isNotEmpty) {
      await _stationService.updateStation(
        documentId: station.documentId,
        numero: numero,
        nom: nom,
        ville: ville,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _numero.dispose();
    _nom.dispose();
    _ville.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: createOrUpdateStation(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.waiting:
            case ConnectionState.active:
              _setUpTextControllerListener();
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 500,
                child: AddStation(
                  numero: _numero,
                  nom: _nom,
                  ville: _ville,
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      );
  }
}
