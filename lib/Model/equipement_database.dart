final String tableEquipements = 'equipements';

class EquipFields {
  static final List<String> values = [
    ///we add all fields
    id,NomEquipement,TypeEquipement,Puissance,Marque,Image,Id_Etage,Id_SSE,
  ];

  static final String id = '_id';
  static final String NomEquipement = '_NomEquipement';
  static final String TypeEquipement = 'TypeEquipement';
  static final String Puissance= 'Puissance';
  static final String Marque = 'Marque';
  static final String Image = 'Image';
  static final String Id_Etage = 'Id_Etage';
  static final String Id_SSE = 'Id_SSE';

}

class Equip {
  int? id;
  String NomEquipement;
  String TypeEquipement;
  double Puissance;
  String Marque;
  String Image;
  int Id_Etage;
  int Id_SSE;

  Equip({
    this.id,
    required this.NomEquipement,
    required this.TypeEquipement,
    required this.Puissance,
    required this.Marque,
    required this.Image,
    required this.Id_SSE,
    required this.Id_Etage,
  });

  Equip copy({
    int? id,
    String? NomEquipement,
    String? TypeEquipement,
    double? Puissance,
    String? Marque,
    String? Image,
    int? Id_Etage,
    int? Id_SSE,
  })=> Equip(
    id:  id ?? this.id,
    NomEquipement: NomEquipement ?? this.NomEquipement,
    TypeEquipement: TypeEquipement ?? this.TypeEquipement,
    Image: Image ?? this.Image,
    Puissance: Puissance ?? this.Puissance,
    Marque:  Marque ?? this.Marque,
    Id_Etage: Id_Etage ?? this.Id_Etage,
    Id_SSE: Id_SSE ?? this.Id_SSE,
  );

  Map<String,Object?> toJson() => {
    EquipFields.id: id,
    EquipFields.NomEquipement: NomEquipement,
    EquipFields.TypeEquipement: TypeEquipement,
    EquipFields.Puissance: Puissance,
    EquipFields.Marque: Marque,
    EquipFields.Image: Image,
    EquipFields.Id_SSE: Id_SSE,
    EquipFields.Id_Etage: Id_Etage,
  };

  static Equip fromJson(Map<String,Object?> json) => Equip(
    id: json[EquipFields.id] as int?,
    TypeEquipement: json[EquipFields.TypeEquipement] as String,
    NomEquipement: json[EquipFields.NomEquipement] as String,
    Image:  json[EquipFields.Image] as String,
    Puissance:  json[EquipFields.Puissance] as double,
    Marque:  json[EquipFields.Marque] as String,
    Id_Etage: json[EquipFields.Id_Etage] as int,
    Id_SSE: json[EquipFields.Id_SSE] as int,
  );
}