import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;

  const PlaceLocation({required this.latitude, required this.longitude});
}

class Places {
  final String id;
  final String name;
  final File image;
  final PlaceLocation placeLocation;

  Places(
      {required this.name,
      required this.image,
      required this.placeLocation,
      String? id})
      : id = id ?? uuid.v4();
}
