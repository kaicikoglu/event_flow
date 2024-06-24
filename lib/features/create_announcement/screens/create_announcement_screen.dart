// path: lib/screens/create_announcement.dart

import 'package:event_flow/features/create_announcement/widgets/announcement_title.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import '../../../data_models/event_data_model.dart';
import '../services/create_announcement_controller.dart';
import '../widgets/announcement_description.dart';
import '../widgets/create_announcement_button.dart';

class CreateAnnouncement extends StatefulWidget {
  final Event event;

  const CreateAnnouncement({super.key, required this.event});

  @override
  _CreateAnnouncementState createState() => _CreateAnnouncementState();
}

class _CreateAnnouncementState extends State<CreateAnnouncement> {
  final _formKey = GlobalKey<FormState>();
  final CreateAnnouncementController _announcementController =
      CreateAnnouncementController();

  @override
  void dispose() {
    _announcementController.dispose();
    super.dispose();
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
              AnnouncementTitle(event: widget.event),
              const SizedBox(height: 16.0),
              Text(
                  'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 16.0),
              AnnouncementDescription(controller: _announcementController),
              const SizedBox(height: 16.0),
              CreateAnnouncementButton(
                controller: _announcementController,
                event: widget.event,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}