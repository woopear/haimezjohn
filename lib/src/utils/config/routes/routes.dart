import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/competence/presentation/private/competence_page_private.dart';
import 'package:haimezjohn/src/models/portfolio/presentation/private/portfolio_page_private.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_page_private.dart';
import 'package:haimezjohn/pages/home_page.dart';

class Routes {
  /// les routes
  final String _home = '/';

  /// les routes admin
  final String _profilPrivate = '/admin/profil';
  final String _competencePrivate = '/admin/competence';
  final String _portfolioPrivate = '/admin/portfolio';

  /// getter
  String get home => _home;

  /// getter admin
  String get profilPrivate => _profilPrivate;
  String get competencePrivate => _competencePrivate;
  String get portfolioPrivate => _portfolioPrivate;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      /// widgets
      _home: (context) => const HomePage(),

      /// widgets admin
      _profilPrivate: (context) => const ProfilPagePrivate(),
      _competencePrivate: (context) => const CompetencePagePrivate(),
      _portfolioPrivate: (context) => const PortfolioPagePrivate(),
    };
  }
}
