// lib/features/home/services/home_content_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_models/event_data_model.dart';
import '../../../main.dart';
import '../../../services/isar_service.dart';

final homeContentControllerProvider = StateNotifierProvider<HomeContentController, AsyncValue<List<Event>>>((ref) {
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
      print('Loading events...');
      final events = await isarService.getAllEvents();
      print('Fetched events: ${events.length}');
      state = AsyncValue.data(events);
    } catch (e) {
      print('Error loading events: $e');
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> deleteEvent(int id) async {
    try {
      print('Deleting event with id: $id');
      await isarService.deleteEvent(id);
      loadEvents();
    } catch (e) {
      print('Error deleting event: $e');
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
