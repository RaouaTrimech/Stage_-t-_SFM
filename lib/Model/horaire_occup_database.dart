import 'dart:convert';
final String tableHorairesOccup = 'horairesOccup';

class HoraireOccupFields {
  static final List<String> values = [
    id,days,debutHour,finHour,id_SsE
  ];

  static  String id = '_id';
  static  String days = '_days';
  static  String debutHour = '_debutHour';
  static  String finHour= '_finHour';
  static  String id_SsE= '_idSsE';


}
class HoraireOccup {
  int? id;
  List<String> days ;
  DateTime debutHour;
  DateTime finHour;
  int id_ssEspace;

  HoraireOccup({ this.id ,
    required this.days,
    required this.debutHour,
    required this.finHour,
    required this.id_ssEspace});

  HoraireOccup copy({
    int? id,
    List<String>? days,
    DateTime? debutHour,
    DateTime? finHour,
    int? id_ssEspace,
  })=> HoraireOccup(
    id:  id ?? this.id,
    days: days ?? this.days,
    debutHour: debutHour ?? this.debutHour,
    finHour: finHour ?? this.finHour,
    id_ssEspace: id_ssEspace ?? this.id_ssEspace,
  );

  Map<String,Object?> toJson() => {
    HoraireOccupFields.id: id,
    HoraireOccupFields.days: jsonEncode(days),
    HoraireOccupFields.debutHour: debutHour.toIso8601String,
    HoraireOccupFields.finHour: finHour.toIso8601String,
    HoraireOccupFields.id_SsE:id_ssEspace,
  };

  static HoraireOccup fromJson(Map<String,Object?> json) => HoraireOccup(
    id: json[HoraireOccupFields.id] as int?,
    id_ssEspace: json[HoraireOccupFields.id_SsE] as int,
    debutHour: DateTime.parse(json[HoraireOccupFields.debutHour]as String),
    finHour: DateTime.parse(json[HoraireOccupFields.finHour]as String),
    days: jsonDecode(HoraireOccupFields.days),

  );
}