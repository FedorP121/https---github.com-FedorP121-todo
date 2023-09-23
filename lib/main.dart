import 'package:flutter/material.dart';
import 'package:todotest/core/servise_locator/servise_lacator.dart';

import 'my_app_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}
