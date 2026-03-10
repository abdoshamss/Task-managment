import '../data_source/hive_service.dart';

abstract class JsonModel {
  Map<String, dynamic> toJson();
  JsonModel fromJson(Map<String, dynamic> json);
}

extension HiveJsonExtension on HiveService {
  static Future<void> putModel<T extends JsonModel>(
    String boxName,
    String key,
    T model,
  ) async {
    await HiveService.putJson(boxName, key, model.toJson());
  }

  static Future<T?> getModel<T extends JsonModel>(
    String boxName,
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final json = await HiveService.getJson(boxName, key);
    if (json != null) return fromJson(json);
    return null;
  }
}
