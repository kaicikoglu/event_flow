import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../main.dart';
import '../../../services/isar_service.dart';

final homeContentControllerProvider =
    StateNotifierProvider<HomeContentController, AsyncValue<List<Event>>>(
        (ref) {
  final isarService = ref.watch(isarServiceProvider);
  return HomeContentController(isarService);
});

class HomeContentController extends StateNotifier<AsyncValue<List<Event>>> {
  final IsarService isarService;
  final TextEditingController searchController = TextEditingController();

  HomeContentController(this.isarService) : super(const AsyncValue.loading()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await isarService.getAllEvents();
      state = AsyncValue.data(events);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> deleteEvent(int id) async {
    try {
      await isarService.deleteEvent(id);
      loadEvents();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  void handleDismiss(BuildContext context, WidgetRef ref, Event event,
      DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      deleteEvent(event.id);
      context.go('/createEvent', extra: event);
    } else if (direction == DismissDirection.endToStart) {
      deleteEvent(event.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${event.title} dismissed')),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
