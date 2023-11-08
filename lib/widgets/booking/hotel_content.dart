import 'package:flutter/material.dart';
import 'package:mypfe/data/data.dart';

class HotelContent extends StatelessWidget {
  final Hotel hotel;
  const HotelContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 210,
      width: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(hotel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              hotel.hotelName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            '${hotel.distance} km du centre',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          Text(
            '${hotel.rating} / 10  (${hotel.voters})',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              hotel.price,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
