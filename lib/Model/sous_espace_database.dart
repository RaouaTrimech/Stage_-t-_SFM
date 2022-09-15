final String tableSousEspaces = 'sousEspace';

class SousEspaceFields {
  static final List<String> values = [
    id,NomBureau,Surface,nbPersonne,NomEtage
  ];

  static final String id = '_id';
  static final String NomBureau = '_NomBureau';
  static final String Surface= 'Surface';
  static final String nbPersonne = 'nbPersonne';
  static final String NomEtage = 'NomEtage';

}

class SsEspace {
  int? id;
  String NomBureau;
  double Surface;
  int nbPersonne;
  int NomEtage;


  SsEspace({
    this.id,
    required this.NomBureau,
    required this.Surface,
    required this.nbPersonne,
    required this.NomEtage,

  });

  SsEspace copy({
    int? id,
    String? NomBureau,
    double? Surface,
    int? nbPersonne,
    int? NomEtage

  })=> SsEspace(
    id:  id ?? this.id,
    NomBureau: NomBureau ?? this.NomBureau,
    Surface: Surface ?? this.Surface,
    nbPersonne:  nbPersonne ?? this.nbPersonne,
    NomEtage: NomEtage ?? this.NomEtage,

  );

  Map<String,Object?> toJson() => {
    SousEspaceFields.id: id,
    SousEspaceFields.NomBureau: NomBureau,
    SousEspaceFields.Surface: Surface,
    SousEspaceFields.nbPersonne: nbPersonne,
    SousEspaceFields.NomEtage: NomEtage,
  };

  static SsEspace fromJson(Map<String,Object?> json) => SsEspace(
    id: json[SousEspaceFields.id] as int?,
    NomBureau: json[SousEspaceFields.NomBureau] as String,
    Surface:  json[SousEspaceFields.Surface] as double,
    nbPersonne:  json[SousEspaceFields.nbPersonne] as int,
    NomEtage: json[SousEspaceFields.NomEtage] as int,
  );
}