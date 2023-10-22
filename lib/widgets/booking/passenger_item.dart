import 'package:flutter/material.dart';
import 'package:mypfe/models/passager.dart';

typedef OnModify = void Function()?;
typedef CheckPassenger = void Function(bool?)?;
typedef OnDelete = void Function()?;

class PassengerItem extends StatelessWidget {
  const PassengerItem({
    super.key,
    required this.value,
    required this.passenger,
    required this.onChanged,
    required this.onDelete, 
    required this.onModify,
  });
  final CloudPassager passenger;
  final bool value;
  final CheckPassenger onChanged;
  final OnDelete onDelete;
  final OnModify onModify;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onModify,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: ListTile(
          leading: Checkbox(
            value: value,
            checkColor: Colors.white,
            onChanged: onChanged,
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
          trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
