import 'package:event_flow/features/resources/services/resources_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../data_models/pictures/picture_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../widgets/picture_grid_widget.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  final Event event;

  const ResourcesScreen({super.key, required this.event});

  @override
  _ResourcesScreen createState() => _ResourcesScreen();
}

class _ResourcesScreen extends ConsumerState<ResourcesScreen> {
  late Future<List<Picture>> _picturesFuture;

  @override
  void initState() {
    super.initState();
    _picturesFuture = _loadPictures();
  }

  Future<List<Picture>> _loadPictures() async {
    final controller = ref.read(resourcesControllerProvider);
    return await controller.getPicturesForEvent(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(resourcesControllerProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Picture>>(
              future: _picturesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No pictures uploaded.'));
                } else {
                  final pictures = snapshot.data!;
                  return PictureGrid(pictures: pictures);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFAB(
        onPressed: () async {
          await controller.pickImage(context, widget.event);
          setState(() {
            _picturesFuture =
                _loadPictures(); // Reload pictures after adding a new one
          });
        },
      ),
    );
  }
}
