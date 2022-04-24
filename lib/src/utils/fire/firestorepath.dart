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
}
