import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event_data_model.dart';
import '../../../main.dart';
import '../../../services/isar_service.dart';

class CreateEventProvider extends StateNotifier<AsyncValue<List<Event>>> {
  final IsarService isarService;

  CreateEventProvider(this.isarService) : super(const AsyncValue.loading());

  Future<void> addEvent(Event event) async {
    await isarService.saveEvent(event);
  }

  Future<void> updateEvent(Event event) async {
    await isarService.saveEvent(event);
  }
}

final createEventProvider = StateNotifierProvider.autoDispose<
    CreateEventProvider, AsyncValue<List<Event>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return CreateEventProvider(isarService);
});
