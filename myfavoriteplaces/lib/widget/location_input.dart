import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:myfavoriteplaces/models/places.dart';

class LocationInput extends StatefulWidget {
  final Function pickLocation;

  const LocationInput({Key? key, required this.pickLocation}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  bool _isGettingLocation = false;

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    _pickedLocation = locationData;
    setState(() {
      _isGettingLocation = false;
    });
    widget.pickLocation(PlaceLocation(
        latitude: locationData.latitude??0.0, longitude: locationData.longitude??0.0));
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      _pickedLocation != null
          ? 'Your Address coordinates \n Longitude: ${_pickedLocation?.longitude} \n Latitude: ${_pickedLocation?.latitude}'
          : 'No Location shows',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get current Location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Select on Map'))
          ],
        )
      ],
    );
  }
}
