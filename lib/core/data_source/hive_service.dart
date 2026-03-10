import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static late HiveAesCipher _keyHiveAesCipher;
  static const String _keyName = "keyName";

  static Future<void> _init() async {
    await Hive.initFlutter();
  }

  static Future<void> init(List<String>? openedBoxes) async {
    late List<int> cipherKey;

    await _init();

    // String? storedKey = await secureStorage.read(key: _keyName);
    // if (storedKey != null) {
    //   cipherKey = base64Decode(storedKey);
    // } else {
    //   cipherKey = Hive.generateSecureKey();
    //   await secureStorage.write(
    //     key: _keyName,
    //     value: base64UrlEncode(cipherKey),
    //   );
    // }
    // _keyHiveAesCipher = HiveAesCipher(cipherKey);

    for (String box in openedBoxes ?? []) {
      await _openBox(box);
    }
  }

  static Future<void> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) return;
    await Hive.openBox(boxName); // <-- أزل encryptionCipher
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

  static Future<Map<String, dynamic>?> getJson(
    String boxName,
    String key,
  ) async {
    await _openBox(boxName);
    final jsonString = await getRaw(boxName: boxName, key: key);
    if (jsonString is String) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> remove(String boxName, String key) async {
    await _openBox(boxName);
    await Hive.box(boxName).delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }

  static Future<bool> contains(String boxName, String key) async {
    await _openBox(boxName);
    return Hive.box(boxName).containsKey(key);
  }

  static ValueListenable listenable(String boxName) {
    final box = Hive.box(boxName);
    return box.listenable();
  }
}
