import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/constants/global_constants.dart';

class HiveSecureStorage {
  static late final Box box;

  static Future<Box> makeSecureStorage(
      String secureKey,
      String boxName,
      ) async {
    const secureStorage = FlutterSecureStorage();
    final secureStorageKey = await secureStorage.read(
      key: secureKey,
    );

    if (secureStorageKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: secureKey,
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: secureKey);
    final encryptionKey = base64Url.decode(key!);

    await Hive.openBox(
      boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    // Get reference to an already opened box
    box = Hive.box(boxName);
    return box;
  }

  static Box getHiveBox({
    String? boxName,
  }) {
    var inputBoxName = boxName ?? GlobalConstants.kSecureBoxName;

    // Get reference to an already opened box
    var box = Hive.box(inputBoxName);
    return box;
  }

  // Add info to box
  static addInfo(
      Box hiveBox,
      String key,
      value,
      ) async {
    // Storing key-value pair
    hiveBox.put(key, value);
  }

  // Read info from box
  static dynamic getInfo(
      Box hiveBox,
      String key,
      ) {
    try {
      if (key.isNotEmpty && key != "") {
        if (hiveBox.containsKey(key)) {
          return hiveBox.get(key);
        }
      }
      return "";
    } catch (ex) {
      return "";
    }
  }

  // Update info of box
  static updateInfo(
      Box hiveBox,
      String key,
      value,
      ) {
    hiveBox.put(key, value);
  }

  // Delete info from box
  static deleteInfo(
      Box hiveBox,
      String key,
      ) {
    hiveBox.delete(key);
  }
}
