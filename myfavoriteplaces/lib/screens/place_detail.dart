import 'package:flutter/material.dart';
import 'package:myfavoriteplaces/models/places.dart';

class PlaceDetail extends StatelessWidget {
  final Places place;

  PlaceDetail({required this.place});

  @override
  Widget build(BuildContext context) {
    // final userPlace = ref.watch(userPlacesProvider.notifier);
    return Scaffold(
        appBar: AppBar(title: Text(place.name)),
        body: Stack(
          children: [
            Hero(
              tag: place.id,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ],
        ));
  }
}
