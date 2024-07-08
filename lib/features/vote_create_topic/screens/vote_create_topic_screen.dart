import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../services/vote_create_topic_controller.dart';
import '../widgets/enter_text.dart';


class CreateTopicScreen extends ConsumerStatefulWidget {
  final Event event;
  // final VotingTopic? topic;

  const CreateTopicScreen({super.key, required this.event});

  @override
  _CreateTopicScreenState createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends ConsumerState<CreateTopicScreen> {
  late CreateTopicController _controller = CreateTopicController(widget.event);
  List<Widget> textFields = [];

  void addTextField() {
    setState(() {
      textFields.add(
        EnterText(
          argument: 'Option:',
          hintText: 'Enter voting option',
          width: 250,
          height: 60,
          controller: TextEditingController(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter option name';
            }
            return null;
          },
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    EnterText(
                      argument: 'Question:',
                      hintText: 'Enter topic name',
                      width: 250,
                      height: 60,
                      controller: _controller.topicNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event name';
                        }
                        return null;
                      },
                      updateText: widget.event?.title,
                    ),
                    EnterText(
                      argument: 'Option:',
                      hintText: 'Enter voting option',
                      width: 250,
                      height: 60,
                      controller: _controller.optionNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter topic name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    EnterText(
                      argument: 'Option:',
                      hintText: 'Enter voting option',
                      width: 250,
                      height: 60,
                      controller: _controller.optionNameController2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter topic name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ...textFields
                  ]
                ),
              ),

              FloatingActionButton(
                onPressed: addTextField,
                child: Icon(Icons.add),
              ),
              CustomWideButton(
                // text: widget.topic != null ? 'Update Topic' : 'Create Topic',
                onPressed: () => _controller.handleSubmit(context, ref), text: 'Create Topic',
              ),
            ],
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
