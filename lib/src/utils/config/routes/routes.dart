import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/competence/presentation/private/competence_page_private.dart';
import 'package:haimezjohn/src/models/contact/presentation/private/contact_page_private.dart';
import 'package:haimezjohn/src/models/link/presentation/private/link_page_private.dart';
import 'package:haimezjohn/src/models/portfolio/presentation/private/portfolio_page_private.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_page_private.dart';
import 'package:haimezjohn/pages/home_page.dart';
import 'package:haimezjohn/src/models_shared/footer/presentation/private/footer_page_private.dart';
import 'package:haimezjohn/src/models_shared/info_perso/presentation/private/info_perso_page_private.dart';

class Routes {
  /// les routes
  final String _home = '/';

  /// les routes admin
  final String _profilPrivate = '/admin/profil';
  final String _competencePrivate = '/admin/competence';
  final String _portfolioPrivate = '/admin/portfolio';
  final String _contactPrivate = '/admin/contact';
  final String _infoPersoPrivate = '/admin/info-perso';
  final String _footerPagePrivate = '/admin/footer';
  final String _linkPagePrivate = '/admin/link';

  /// getter
  String get home => _home;

  /// getter admin
  String get profilPrivate => _profilPrivate;
  String get competencePrivate => _competencePrivate;
  String get portfolioPrivate => _portfolioPrivate;
  String get contactPrivate => _contactPrivate;
  String get infoPersoPrivate => _infoPersoPrivate;
  String get footerPagePrivate => _footerPagePrivate;
  String get linkPagePrivate => _linkPagePrivate;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      /// widgets
      _home: (context) => const HomePage(),

      /// widgets admin
      _profilPrivate: (context) => const ProfilPagePrivate(),
      _competencePrivate: (context) => const CompetencePagePrivate(),
      _portfolioPrivate: (context) => const PortfolioPagePrivate(),
      _contactPrivate: (context) => const ContactPagePrivate(),
      _infoPersoPrivate: (context) => const InfoPersoPagePrivate(),
      _footerPagePrivate: (context) => const FooterPagePrivate(),
      _linkPagePrivate: (context) => const LinkPagePrivate(),
    };
  }
}
