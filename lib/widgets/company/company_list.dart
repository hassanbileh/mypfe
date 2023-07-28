import 'package:flutter/material.dart';
import 'package:mypfe/models/users.dart';
import 'package:mypfe/utilities/dialogs/delete_dialog.dart';

typedef CompanyCallBack = void Function(CloudUser note);

class CompanyList extends StatelessWidget {
  final Iterable<CloudUser?> companies;
  final CompanyCallBack onDeleteCompany;

  const CompanyList({
    super.key,
    required this.companies,
    required this.onDeleteCompany,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies.elementAt(index);
        return Card(
          child: Dismissible(
            key: ValueKey(companies.elementAt(index)),
            onDismissed: (direction) async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteCompany(company);
              }
            },
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            child: Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    company!.nom!,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 148, 115, 238),
                    ),
                    onPressed: () async {
                      final shouldDelete = await showDeleteDialog(context);
                      if (shouldDelete) {
                        onDeleteCompany(company);
                      }
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Email : ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              company.email,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Telephone : ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              company.telephone.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
