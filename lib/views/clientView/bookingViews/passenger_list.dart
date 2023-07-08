import 'package:flutter/material.dart';
import 'package:mypfe/models/passager.dart';

typedef TicketCallBack = void Function(CloudPassager passengers);

class PassengerList extends StatefulWidget {
  const PassengerList({
    super.key,
    required this.passengers,
    required this.onModify,
    required this.onDelete,
  });
  final Iterable<CloudPassager> passengers;
  final TicketCallBack onModify;
  final TicketCallBack onDelete;

  @override
  State<PassengerList> createState() => _PassengerListState();
}

class _PassengerListState extends State<PassengerList> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.passengers.length,
      itemBuilder: (context, index) {
        final passenger = widget.passengers.elementAt(index);
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ListTile(
            leading: Checkbox(
              value: checkValue,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  checkValue = value as bool;
                });
              },
            ),
            title: Text(passenger.nom),
            subtitle: Row(
              children: [
                Text(passenger.age.toString()),
                const SizedBox(
                  width: 5,
                ),
                const Text("|"),
                const SizedBox(
                  width: 5,
                ),
                Text(passenger.nationalite!)
              ],
            ),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}
