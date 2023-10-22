import 'package:flutter/material.dart';
import 'package:mypfe/models/passager.dart';
import 'package:mypfe/widgets/booking/passenger_item.dart';

typedef OnModify = void Function()?;
typedef OnDelete = void Function()?;
typedef OnChangeCallBack = void Function(bool?)?;

class AddedPassengers extends StatelessWidget {
  const AddedPassengers({
    super.key,
    required this.passengers,
    required this.onModify,
    required this.onDelete,
    required this.onChange,
    required this.checkValue,
  });
  final Iterable<CloudPassager> passengers;
  final OnModify onModify;
  final OnDelete onDelete;
  final OnChangeCallBack onChange;
  final bool checkValue;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passengers.length,
      itemBuilder: (context, index) {
        final passenger = passengers.elementAt(index);
        return PassengerItem(
          value: checkValue,
          passenger: passenger,
          onChanged: onChange,
          onDelete: onDelete, onModify: onModify,
        );
      },
    );
  }
}
