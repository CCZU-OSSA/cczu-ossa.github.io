import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onenavigation/impl/yaml.dart';
import 'package:onenavigation/pages/home.dart';
import 'package:arche/arche.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ArcheBus.bus.provide(ArcheConfig.memory(
      init: await rootBundle.loadString("resource/config.yaml"),
      serializer: YamlSerializer()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var config = ArcheBus.config;
    return MaterialApp(
      title: config.getOr(
        "title",
        "One Navigation",
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(),
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
