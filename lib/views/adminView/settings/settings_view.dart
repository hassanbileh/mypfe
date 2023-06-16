import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<String> _settingItems = ['paramètre profile', 'Gérer admins', 'Gérer paiement'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _settingItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _settingItems[index],
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
