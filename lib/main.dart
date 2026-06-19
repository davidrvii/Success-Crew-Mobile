/// File: lib/main.dart
/// Generated Documentation for main.dart

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/di/service_locator.dart';

/// Method `main` returning `Future<void>`.
/// Handles logic operations related to `main`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  await setupLocator();

  runApp(const App());
}
