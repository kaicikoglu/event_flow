import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../main.dart';

class AnnouncementProvider extends StateNotifier<AsyncValue<List<Event>>> {
  final IsarService isarService;
  final Set<int> _eventsWithNewAnnouncements = {};

  AnnouncementProvider(this.isarService) : super(const AsyncValue.loading());

  void markEventWithNewAnnouncement(int eventId) {
    _eventsWithNewAnnouncements.add(eventId);
    state = AsyncValue.data(state.value ?? []);
  }
}

final announcementProvider = StateNotifierProvider.autoDispose<
    AnnouncementProvider, AsyncValue<List<Event>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return AnnouncementProvider(isarService);
});
