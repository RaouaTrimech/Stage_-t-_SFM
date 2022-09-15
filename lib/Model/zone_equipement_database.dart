final String tableZoneEquip = 'zonesEquipements';

class ZoneEquipFields {
  static final List<String> values = [
    id,NomZone,IdBoltix,
  ];

  static final String id = '_id';
  static final String NomZone = 'NomZone';
  static final String IdBoltix = 'IdBoltix';
}

class ZoneEquip {
  int? id;
  String NomZone;
  String IdBoltix;

  ZoneEquip({
    this.id,
    required this.NomZone,
    required this.IdBoltix,

  });

  ZoneEquip copy({
    int? id,
    String? NomZone,
    String? IdBoltix,

  })=> ZoneEquip(
    id:  id ?? this.id,
    NomZone: NomZone ?? this.NomZone,
    IdBoltix: IdBoltix ?? this.IdBoltix,
  );

  Map<String,Object?> toJson() => {
    ZoneEquipFields.id: id,
    ZoneEquipFields.NomZone: NomZone,
    ZoneEquipFields.IdBoltix: IdBoltix,

  };

  static ZoneEquip fromJson(Map<String,Object?> json) => ZoneEquip(
    id: json[ZoneEquipFields.id] as int?,
    NomZone: json[ZoneEquipFields.NomZone] as String,
    IdBoltix: json[ZoneEquipFields.IdBoltix] as String,

  );
}