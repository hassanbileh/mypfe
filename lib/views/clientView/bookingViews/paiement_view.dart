import 'package:flutter/material.dart';

class PaiementView extends StatefulWidget {
  const PaiementView({super.key});

  @override
  State<PaiementView> createState() => _PaiementViewState();
}

class _PaiementViewState extends State<PaiementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Paiement',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Passagers",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),

            Container(margin: EdgeInsets.all(10),height: 200, width: 400, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
