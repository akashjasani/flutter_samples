import 'dart:io';

import '../models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../utils/constants.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
      path.join(dbPath.toString(), Constant.DB_NAME), onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE ${Constant.TABLE_USER_PLACES}(${Constant.ID} TEXT PRIMARY KEY, ${Constant.TITLE} TEXT, ${Constant.IMAGE} TEXT, ${Constant.LAT} REAL, ${Constant.LNG} REAL)');
  }, version: 1);
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query(Constant.TABLE_USER_PLACES);

    final places = data
        .map((row) => Places(
            id: row[Constant.ID] as String,
            name: row[Constant.TITLE] as String,
            image: File(row[Constant.IMAGE] as String),
            placeLocation: PlaceLocation(
                latitude: row[Constant.LAT] as double,
                longitude: row[Constant.LNG] as double)))
        .toList();
    state = places;
  }

  Future<void> addPlace(
      String name, File image, PlaceLocation placeLocation) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    final place =
        Places(name: name, image: copiedImage, placeLocation: placeLocation);
    final db = await _getDatabase();
    db.insert(Constant.TABLE_USER_PLACES, {
      Constant.ID: place.id,
      Constant.TITLE: place.name,
      Constant.IMAGE: place.image.path,
      Constant.LAT: place.placeLocation.latitude,
      Constant.LNG: place.placeLocation.longitude
    });

    state = [place, ...state];
  }

  Places findById(String id) {
    return state.firstWhere((element) => element.id == id);
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
        (ref) => UserPlacesNotifier());
