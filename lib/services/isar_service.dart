import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../data_models/event_data_model.dart';

class IsarService {
  late Isar _isar;

  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [EventSchema],
      directory: dir.path,
    );
  }

  Future<void> saveEvent(Event event) async {
    await _isar.writeTxn(() async {
      await _isar.events.put(event);
    });
  }

  Future<void> deleteEvent(int id) async {
    await _isar.writeTxn(() async {
      await _isar.events.delete(id);
    });
  }

  Future<List<Event>> getAllEvents() async {
    final events = await _isar.events.where().findAll();
    return events;
  }
}
