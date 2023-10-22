import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/services/cloud/storage/passager_storage.dart';

import '../../../constants/routes.dart';
import '../../../models/passager.dart';
import '../../../widgets/booking/added_passengers.dart';

class PassengersList extends StatelessWidget {
  const PassengersList({
    super.key,
    required this.passengerService,
    required this.client,
  });

  final FirebaseCloudPassagerStorage passengerService;
  final String client;

  @override
  Widget build(BuildContext context) {
    final forPassengers = context.getArguments<CloudReservation>();
    return SingleChildScrollView(
      child: Expanded(
        child: StreamBuilder(
          stream: passengerService.getPassengers(client: client),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final allPassengers = snapshot.data as Iterable<CloudPassager>;
      
                  return Column(
                    children: [
                      //Add Passenger
                      Container(
                        height: 80,
                        margin: const EdgeInsets.all(30),
                        color: Colors.white.withOpacity(0.7),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 113, 68, 239),
                                    Color.fromARGB(255, 183, 128, 255),
                                  ],
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        addPassengerRoute,
                                        arguments: forPassengers);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Ajouter un passager",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
      
                      //Title
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Passagers Recents",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                      AddedPassengers(
                          passengers: allPassengers,
                          onModify: () {},
                          onDelete: () {},
                          onChange: (value) {},
                          checkValue: true),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
      
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
