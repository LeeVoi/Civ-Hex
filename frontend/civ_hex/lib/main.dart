import 'package:civ_hex/civ_hex_app.dart';
import 'package:civ_hex/models/data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [Provider<DataSource>(create: (context) => FakeDataSource())],
      child: CivHexApp(),
      ),
  );
}
