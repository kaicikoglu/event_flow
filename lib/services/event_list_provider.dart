import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_models/event/event_data_model.dart';
import '../main.dart';
import '../services/isar_service.dart';

class EventListProvider extends StateNotifier<AsyncValue<List<Event>>> {
  final IsarService isarService;
  final Set<int> _eventsWithNewAnnouncements =
      {}; // Track events with new announcements

  EventListProvider(this.isarService) : super(const AsyncValue.loading()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await isarService.getAllEvents();
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEvent(Event event) async {
    await isarService.saveEvent(event);
    loadEvents();
  }

  Future<void> removeEvent(int id) async {
    await isarService.deleteEvent(id);
    loadEvents();
  }

  Future<void> updateEvent(Event event) async {
    await isarService.saveEvent(event);
    loadEvents();
  }

  Future<void> searchEvents(String query) async {
    try {
      final events = await isarService.getAllEvents();
      final filteredEvents = events
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredEvents);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> checkAnnouncement(Event event) async {
    await isarService.announcementHasBeenChecked(event);
    _eventsWithNewAnnouncements.remove(event.id); // Mark as checked
    loadEvents();
  }

  void markEventWithNewAnnouncement(int eventId) {
    _eventsWithNewAnnouncements.add(eventId);
    state = AsyncValue.data(state.value ?? []);
  }

  bool hasNewAnnouncement(int eventId) {
    return _eventsWithNewAnnouncements.contains(eventId);
  }
}

final eventNotifierProvider =
    StateNotifierProvider<EventListProvider, AsyncValue<List<Event>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return EventListProvider(isarService);
});
