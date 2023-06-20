import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';

class TrainView extends StatefulWidget {
  const TrainView({super.key});

  @override
  State<TrainView> createState() => _TrainViewState();
}

class _TrainViewState extends State<TrainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: const Center(
        child: Text('Train View'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(addTrainRoute);
        },
      ),
    );
  }
}