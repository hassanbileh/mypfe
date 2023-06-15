import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/users.dart';
import 'package:mypfe/widgets/no_item.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  late final List<CloudUser> _companiesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: (_companiesList.isEmpty)
            ? const NoItem(title: 'Aucune compagnie trouvée.')
            : Column(
                children: [
                  const Text('Compagnies recents'),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateCompanyRoute);
        },
      ),
    );
  }
}
