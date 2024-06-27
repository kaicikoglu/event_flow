// path: lib/data_models/voting_data_model.dart


import 'package:isar/isar.dart';
part 'voting_data_model.g.dart';




@Collection()
class Vote {
  Id id = Isar.autoIncrement;

  late String name;

  Vote();

}

