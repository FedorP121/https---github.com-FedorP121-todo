import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:todotest/feature/aut_feature/domain/entities/password.dart';

abstract interface class ISecureStorage {
  Future<bool> writePassword(String password);
  Future<bool> readPassword();
  Future<bool> loginPassword(Password password);
}

@injectable
class SecureStorage implements ISecureStorage {
  final storage = const FlutterSecureStorage();

  @override
  Future<bool> writePassword(String password) async {
    try {
      await storage.write(key: 'password', value: password);
      debugPrint('пароль записан');
      return true;
    } catch (e) {
      debugPrint('пароль не записан');
      return false;
    }
  }

  @override
  Future<bool> readPassword() async {
    // await storage.deleteAll();
    final String? password = await storage.read(key: 'password');
    return password != null;
  }

  @override
  Future<bool> loginPassword(passwordModel) async {
    final String? password = await storage.read(key: 'password');
    if (passwordModel.password == password) {
      return true;
    }
    return false;
  }
}
