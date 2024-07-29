import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../services/create_event_controller.dart';
import '../widgets/enter_date.dart';
import '../widgets/enter_location.dart';
import '../widgets/enter_text.dart';
import '../widgets/enter_time.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  final Event? event;
  final BackButton? backButton;

  const CreateEventScreen({super.key, this.event, this.backButton});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  late CreateEventController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateEventController(editingEvent: widget.event);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = screenWidth * 0.5; // Set to 70% of screen width
    double maxFieldWidth = 300; // Maximum width

    if (fieldWidth > maxFieldWidth) {
      fieldWidth = maxFieldWidth;
    }

    return Scaffold(
      appBar: AppBar(
        leading: widget.backButton,
        title: Text(widget.event != null ? 'Edit Event' : 'Create Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              EnterText(
                argument: 'Event Name:',
                hintText: 'Enter event name',
                width: fieldWidth,
                height: 60,
                controller: _controller.eventNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
                updateText: widget.event?.title,
              ),
              const SizedBox(height: 16),
              EnterTime(
                argument: 'Time:',
                width: fieldWidth,
                height: 60,
                controller: _controller.timeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time';
                  }
                  return null;
                },
                eventController: _controller,
              ),
              const SizedBox(height: 16),
              EnterDate(
                argument: 'Date:',
                width: fieldWidth,
                height: 60,
                controller: _controller.startDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
                eventController: _controller,
              ),
              const SizedBox(height: 16),
              EnterLocation(
                argument: 'Location:',
                hintText: 'Enter location',
                width: fieldWidth,
                height: 60,
                controller: _controller.locationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                updateLocation: widget.event?.location,
              ),
              const SizedBox(height: 16),
              CustomWideButton(
                text: widget.event != null ? 'Update Event' : 'Create Event',
                onPressed: () =>
                    _controller.handleSubmit(context, ref, widget.event),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
