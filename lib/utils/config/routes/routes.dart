import 'package:flutter/material.dart';
import 'package:haimezjohn/pages/home_page.dart';

class Routes {
  /// les routes
  final String _home = '/';

  /// getter
  String get home => _home;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const HomePage(),
    };
  }
}
