final String tableEquipements = 'equipements';

class EquipFields {
  static final List<String> values = [
    ///we add all fields
    id,NomEquipement,TypeEquipement,Puissance,Marque,Image
  ];

  static final String id = '_id';
  static final String NomEquipement = '_NomEquipement';
  static final String TypeEquipement = 'TypeEquipement';
  static final String Puissance= 'Puissance';
  static final String Marque = 'Marque';
  static final String Image = 'Image';

}

class Equip {
  int? id;
  String NomEquipement;
  String TypeEquipement;
  double Puissance;
  String Marque;
  String Image;

  Equip({
    this.id,
    required this.NomEquipement,
    required this.TypeEquipement,
    required this.Puissance,
    required this.Marque,
    required this.Image,

  });

  Equip copy({
    int? id,
    String? NomEquipement,
    String? TypeEquipement,
    double? Puissance,
    String? Marque,
    String? Image,

  })=> Equip(
    id:  id ?? this.id,
    NomEquipement: NomEquipement ?? this.NomEquipement,
    TypeEquipement: TypeEquipement ?? this.TypeEquipement,
    Image: Image ?? this.Image,
    Puissance: Puissance ?? this.Puissance,
    Marque:  Marque ?? this.Marque,
  );

  Map<String,Object?> toJson() => {
    EquipFields.id: id,
    EquipFields.NomEquipement: NomEquipement,
    EquipFields.TypeEquipement: TypeEquipement,
    EquipFields.Puissance: Puissance,
    EquipFields.Marque: Marque,
    EquipFields.Image: Image,
  };

  static Equip fromJson(Map<String,Object?> json) => Equip(
    id: json[EquipFields.id] as int?,
    TypeEquipement: json[EquipFields.TypeEquipement] as String,
    NomEquipement: json[EquipFields.NomEquipement] as String,
    Image:  json[EquipFields.Image] as String,
    Puissance:  json[EquipFields.Puissance] as double,
    Marque:  json[EquipFields.Marque] as String,
  );
}