import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_page_private.dart';
import 'package:haimezjohn/pages/home_page.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _profilPrivate = '/admin/profil';

  /// getter
  String get home => _home;
  String get profilPrivate => _profilPrivate;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const HomePage(),
      _profilPrivate: (context) => const ProfilPagePrivate(),
    };
  }
}
