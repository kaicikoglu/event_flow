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
        final String newPath =
            '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
        await image.saveTo(newPath);

        await event.createPicture(isarService.getIsar(), newPath);

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

  Future<void> deletePicture(Picture picture) async {
    try {
      await isarService.deletePicture(picture);
    } catch (e) {
      print('Error deleting picture: $e');
    }
  }

  void showDeleteDialog(
      BuildContext context, Picture picture, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Picture'),
          content: const Text('Are you sure you want to delete this picture?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showEnlargedImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double dialogHeight = screenHeight * 0.6;

        return Dialog(
          child: SizedBox(
            height: dialogHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.file(File(imagePath)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
