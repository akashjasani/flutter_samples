import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfavoriteplaces/providers/user_places.dart';
import '../screens/add_places.dart';
import '../widget/place_list.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PlaceListScreen> createState() => _PlaceListScreen();
}

class _PlaceListScreen extends ConsumerState<PlaceListScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlace = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: _placeFuture,
          builder: (tx, snap) => snap.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PlaceList(placeList: userPlace)),
    );
  }
}
