import 'package:mypfe/assets/assets.dart';

class Hotel {
  final String hotelName, distance, price, imageUrl, rating,voters;

  const Hotel({
    required this.hotelName,
    required this.distance,
    required this.price,
    required this.imageUrl,
    required this.voters,
    required this.rating,
  });
}

const List<Hotel> hotels = [
  Hotel(
    hotelName: 'Hotel Kennedy',
    distance: '1,9',
    price: '52 €',
    imageUrl: Assets.roomOne,
    voters: '934',
    rating: '8,2',
  ),
  Hotel(
    hotelName: 'Hotel Central Station',
    distance: '2,9',
    price: '217 €',
    imageUrl: Assets.roomTwo,
    voters: '446',
    rating: '9,1',
  ),
  Hotel(
    hotelName: 'Hotel Emmy',
    distance: '8,0',
    price: '154 €',
    imageUrl: Assets.roomThree,
    voters: '1072',
    rating: '8,2',
  ),
  Hotel(
    hotelName: 'Mia Aparthotel',
    distance: '9,1',
    price: '312 €',
    imageUrl: Assets.roomFour,
    voters: '541',rating: '7,9',
  ),
  Hotel(
    hotelName: 'Hotel Metropoli',
    distance: '2,9',
    price: '245 €',
    imageUrl: Assets.roomFive,
    voters: '2831',
    rating: '9,5',
  ),
];
