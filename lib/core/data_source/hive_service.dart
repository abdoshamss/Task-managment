import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> _init() async {
    await Hive.initFlutter();
  }

  static Future<void> init(List<String>? openedBoxes) async {
    await _init();

    for (String box in openedBoxes ?? []) {
      await _openBox(box);
    }
  }

  static Future<void> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) return;
    await Hive.openBox(boxName);
  }

  static Future<void> putRaw({
    required String boxName,
    required String key,
    dynamic value,
  }) async {
    await _openBox(boxName);
    await Hive.box(boxName).put(key, value);
  }

  static dynamic getRaw({required String boxName, required String key}) {
    // await _openBox(boxName);
    final item = Hive.box(boxName).get(key);
    return item;
  }

  static Future<void> putJson(
    String boxName,
    String key,
    Map<String, dynamic> json,
  ) async {
    final jsonString = jsonEncode(json);
    await putRaw(boxName: boxName, key: key, value: jsonString);
  }

  static Future<void> remove(String boxName, String key) async {
    await _openBox(boxName);
    await Hive.box(boxName).delete(key);
  }
}
