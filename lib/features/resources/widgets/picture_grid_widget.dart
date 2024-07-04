import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data_models/pictures/picture_data_model.dart';

class PictureGrid extends StatelessWidget {
  final List<Picture> pictures;

  const PictureGrid({super.key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        final picture = pictures[index];
        return Image.file(File(picture.imagePath));
      },
    );
  }
}
