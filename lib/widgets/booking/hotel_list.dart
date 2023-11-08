import 'package:flutter/material.dart';
import 'package:mypfe/data/data.dart';
import 'package:mypfe/widgets/booking/hotel_content.dart';

class HotelList extends StatelessWidget {
  const HotelList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 15.0,),
            child: Text(
              'Besoin d\'un hébergement en Ethiopie ?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return HotelContent(hotel: hotel,);
                
              },
              itemCount: hotels.length,
            ),
          ),
        ],
      ),
    );
  }
}
