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
          elevation: 2,
          child: Dismissible(
            key: ValueKey(companies.elementAt(index)),
            onDismissed: (direction) async {
              final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteCompany(company);
                  }
            },
            background: Container(color: Theme.of(context).colorScheme.error,),
            child: ListTile(
              
              title: Text(
                company!.nom!,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteCompany(company);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
