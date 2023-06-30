import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfavoriteplaces/models/places.dart';
import 'package:myfavoriteplaces/widget/image_input.dart';
import '../providers/user_places.dart';
import '../widget/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _nameController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? placeLocation;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void pickedImage(File image) {
    _selectedImage = image;
  }

  void pickedLocation(PlaceLocation placeLocation) {
    this.placeLocation = placeLocation;
  }

  void _addPlace() {
    setState(() {
      final enteredText = _nameController.text;
      if (enteredText.isEmpty ||
          _selectedImage == null ||
          placeLocation == null) {
        return;
      }
      ref
          .read(userPlacesProvider.notifier)
          .addPlace(enteredText, _selectedImage!, placeLocation!);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: pickedImage,
            ),
            const SizedBox(
              height: 16,
            ),
            LocationInput(pickLocation: pickedLocation),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
                onPressed: _addPlace,
                label: const Text('Add Place'),
                icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
