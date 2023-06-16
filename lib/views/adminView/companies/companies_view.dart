import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/constants/user_constants.dart';
import 'package:mypfe/models/users.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/widgets/company_list.dart';
import 'package:mypfe/widgets/no_item.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  late final List<CloudUser> _companiesList = [];
  late final FirebaseCloudUserStorage _notesServices;

  @override
  void initState() {
    _notesServices = FirebaseCloudUserStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: (_companiesList.isEmpty)
            ? const NoItem(title: 'Aucune compagnie trouvée.')
            : StreamBuilder(
                stream: _notesServices.getAllUsers(role: partenaire),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allUsers = snapshot.data as Iterable<CloudUser>;
                        return CompanyList(
                          companies: allUsers,
                          onDeleteCompany: (CloudUser compagnie) async {
                            await _notesServices.deleteUser(
                                documentId: compagnie.documentId);
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    case ConnectionState.done:
                      return const Text('done');
                    default:
                      return const CircularProgressIndicator();
                  }
                },
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
