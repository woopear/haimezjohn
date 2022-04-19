import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_page_private.dart';
import 'package:haimezjohn/pages/home_page.dart';

class Routes {
  /// les routes
  final String _home = '/';

  /// les routes admin
  final String _profilPrivate = '/admin/profil';

  /// getter
  String get home => _home;

  /// getter admin
  String get profilPrivate => _profilPrivate;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      /// widgets
      _home: (context) => const HomePage(),

      /// widgets admin
      _profilPrivate: (context) => const ProfilPagePrivate(),
    };
  }
}
