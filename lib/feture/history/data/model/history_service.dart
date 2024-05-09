import 'package:hive/hive.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';

class HistoryService {
  static get(context) => HistoryService();
  final String _boxname = 'notetable';
  Future<Box<HistoryModel>> get _box async =>
      await Hive.openBox<HistoryModel>(_boxname);

  Future<void> addItem(HistoryModel note) async {
    var box = await _box;
    box.add(note);
  }

  Future<List<HistoryModel>> getAllNote() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteNote(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> ubdatIsCombleted(int index, HistoryModel note) async {
    var box = await _box;
    await box.putAt(index, note);
  }
}
