import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/pictures/picture_data_model.dart';
import '../services/resources_controller.dart';

class PictureGrid extends ConsumerWidget {
  final List<Picture> pictures;
  final VoidCallback onDeleteComplete;

  const PictureGrid(
      {super.key, required this.pictures, required this.onDeleteComplete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(resourcesControllerProvider);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        final picture = pictures[index];
        final file = File(picture.imagePath);

        return GestureDetector(
          onTap: () => controller.showEnlargedImage(context, picture.imagePath),
          onLongPress: () =>
              controller.showDeleteDialog(context, picture, () async {
            await controller.deletePicture(picture);
            onDeleteComplete();
          }),
          child: FutureBuilder<bool>(
            future: file.exists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.data!) {
                return const Center(child: Text('Image not found'));
              } else {
                return Image.file(file);
              }
            },
          ),
        );
      },
    );
  }
}
