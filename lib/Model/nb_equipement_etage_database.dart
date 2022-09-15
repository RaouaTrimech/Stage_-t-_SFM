final String tableNbEquipSSE = 'nbEquipSse';

class NbEquipSSEFields {
  static final List<String> values = [
    id_Equip,id_SSE,nbre
  ];

  static final String id_Equip = '_id_Equip';
  static final String id_SSE = '_idSSE';
  static final String nbre= 'nbre';

}

class NbEquipSSE {
  int id_Equip;
  int id_SSE;
  int nbre;


  NbEquipSSE({
    required this.id_Equip,
    required this.id_SSE,
    required this.nbre,
  });

  NbEquipSSE copy({
     int? id_Equip,
     int? id_SSE,
     int? nbre,

  })=> NbEquipSSE(
    id_Equip:  id_Equip ?? this.id_Equip,
    id_SSE: id_SSE ?? this.id_SSE,
    nbre: nbre ?? this.nbre,

  );

  Map<String,Object?> toJson() => {
    NbEquipSSEFields.id_Equip: id_Equip,
    NbEquipSSEFields.id_SSE: id_SSE,
    NbEquipSSEFields.nbre: nbre,
  };

  static NbEquipSSE fromJson(Map<String,Object?> json) => NbEquipSSE(
    id_Equip: json[NbEquipSSEFields.id_Equip] as int,
    id_SSE: json[NbEquipSSEFields.id_SSE] as int,
    nbre:  json[NbEquipSSEFields.nbre] as int,
  );
}