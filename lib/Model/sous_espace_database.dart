final String tableSousEspaces = 'sousEspace';

class SousEspaceFields {
  static final List<String> values = [
    id,NomBureau,Surface,nbPersonne,IdEtage
  ];

  static final String id = '_id';
  static final String NomBureau = '_NomBureau';
  static final String Surface= 'Surface';
  static final String nbPersonne = 'nbPersonne';
  static final String IdEtage = 'IdEtage';

}

class SsEspace {
  int? id;
  String NomBureau;
  double Surface;
  int nbPersonne;
  int IdEtage;


  SsEspace({
    this.id,
    required this.NomBureau,
    required this.Surface,
    required this.nbPersonne,
    required this.IdEtage,

  });

  SsEspace copy({
    int? id,
    String? NomBureau,
    double? Surface,
    int? nbPersonne,
    int? IdEtage

  })=> SsEspace(
    id:  id ?? this.id,
    NomBureau: NomBureau ?? this.NomBureau,
    Surface: Surface ?? this.Surface,
    nbPersonne:  nbPersonne ?? this.nbPersonne,
    IdEtage: IdEtage ?? this.IdEtage,

  );

  Map<String,Object?> toJson() => {
    SousEspaceFields.id: id,
    SousEspaceFields.NomBureau: NomBureau,
    SousEspaceFields.Surface: Surface,
    SousEspaceFields.nbPersonne: nbPersonne,
    SousEspaceFields.IdEtage: IdEtage,
  };

  static SsEspace fromJson(Map<String,Object?> json) => SsEspace(
    id: json[SousEspaceFields.id] as int?,
    NomBureau: json[SousEspaceFields.NomBureau] as String,
    Surface:  json[SousEspaceFields.Surface] as double,
    nbPersonne:  json[SousEspaceFields.nbPersonne] as int,
    IdEtage: json[SousEspaceFields.IdEtage] as int,
  );
}