import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../data_models/pictures/picture_data_model.dart';
import '../../../main.dart';
import '../../../services/isar_service.dart';

final resourcesControllerProvider = Provider<ResourcesController>((ref) {
  final isarService = ref.read(isarServiceProvider);
  return ResourcesController(isarService: isarService, ref: ref);
});

class ResourcesController {
  final IsarService isarService;
  final ProviderRef ref;

  ResourcesController({required this.isarService, required this.ref});

  Future<List<Picture>> getPicturesForEvent(Event event) async {
    return await isarService.getPicturesForEvent(event);
  }

  Future<void> pickImage(BuildContext context, Event event) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String path = '${appDir.path}/${image.name}';
        await image.saveTo(path);

        await isarService.savePicture(event, path);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Picture uploaded successfully!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No image selected.'),
        ));
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image: $e'),
      ));
    }
  }
}
