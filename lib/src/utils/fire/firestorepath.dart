class FirestorePath {
  /// setting
  static String settings() => 'settings';
  static String setting(String idSetting) => 'settings/$idSetting';

  /// profil
  static String profils() => 'profils';
  static String profil(String idProfil) => 'profils/$idProfil';

  /// competence
  static String competences() => 'competences';
  static String competence(String idCompetence) => 'competences/$idCompetence';

  /// techno
  static String technos(idComptence) => 'competences/$idComptence/technos';
  static String techno(String idCompetence, String idTechno) =>
      'competences/$idCompetence/technos/$idTechno';

  /// portfolio
  static String portfolios() => 'portfolios';
  static String portfolio(String idPortfolio) => 'portfolios/$idPortfolio';

  /// projet
  static String projets(String idPortfolio) =>
      'portfolios/$idPortfolio/projets';
  static String projet(String idPortfolio, String idProjet) =>
      'portfolios/$idPortfolio/projets/$idProjet';

  /// contact
  static String contacts() => "contacts";
  static String contact(String idContact) => "contacts/$idContact";

  /// info perso
  static String infoPersos() => "info_persos";
  static String infoPerso(String idInfoPerso) => "info_persos/$idInfoPerso";

  /// footer
  static String footers() => "footers";
  static String footer(String idFooter) => "footers/$idFooter";

  /// link
  static String links() => "links";
  static String link(String idLink) => "links/$idLink";

}
