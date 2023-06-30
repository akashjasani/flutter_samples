import 'package:flutter/material.dart';
import 'package:myfavoriteplaces/models/places.dart';
import 'package:myfavoriteplaces/screens/place_detail.dart';

class PlaceList extends StatelessWidget {
  final List<Places> placeList;

  const PlaceList({Key? key, required this.placeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (placeList.isEmpty) {
      return const Center(
        child: Text("No places added"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDetail(place: placeList[i]),
            ));
          },
          child: ListTile(
            title: Text(
              placeList[i].name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
                'Your Coordinates: \nLongitude: ${placeList[i].placeLocation.longitude}, \nLatitude: ${placeList[i].placeLocation.latitude}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            leading: Hero(
              tag: placeList[i].id,
              child: CircleAvatar(
                  radius: 26, backgroundImage: FileImage(placeList[i].image)),
            ),
          ),
        ),
        itemCount: placeList.length,
      );
    }
  }
}
