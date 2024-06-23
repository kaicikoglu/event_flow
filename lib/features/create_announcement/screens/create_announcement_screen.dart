import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event_data_model.dart';

class CreateAnnouncement extends StatefulWidget {
  final Event event;

  const CreateAnnouncement({super.key, required this.event});

  @override
  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createAnnouncement() async {
    if (_formKey.currentState!.validate()) {
      final String description = _descriptionController.text;
      final isar = Isar.getInstance();

      if (isar != null) {
        await widget.event.createAnnouncement(isar, description);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Announcement created successfully!')),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: const Text('Create Announcement'),
      selectedIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Title: ${widget.event.title}'),
              const SizedBox(height: 16.0),
              Text(
                  'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createAnnouncement,
                child: const Text('Create Announcement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
