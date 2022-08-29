final String tableSites = 'sites';

class SiteFields {
  static final List<String> values = [
    ///we add all fields
    id,NomSite,AdresseSite,AnneeConstruction,Activite,SurfaceSHON,GTB_GTC,reseauTGBTetudie,typeSite
  ];

  static final String id = '_id';
  static final String NomSite = '_NomSite';
  static final String AdresseSite = 'AdresseSite';
  static final String AnneeConstruction = 'AnneeConstruction';
  static final String Activite ='Activite';
  static final String SurfaceSHON= 'SurfaceSHON';
  static final String GTB_GTC = 'GTB_GTC';
  static final String reseauTGBTetudie = 'reseauTGBTetudie';
  static final String typeSite = 'typeSite';
}

class Site {
  int? id;
  String NomSite;
  String AdresseSite;
  String AnneeConstruction;
  String Activite;
  double SurfaceSHON;
  String GTB_GTC;
  String reseauTGBTetudie;
  String typeSite;

  Site({
    this.id,
    required this.NomSite,
    required this.AdresseSite,
    required this.AnneeConstruction,
    required this.Activite,
    required this.SurfaceSHON,
    required this.GTB_GTC,
    required this.reseauTGBTetudie,
    required this.typeSite,
  });

  Site copy({
    int? id,
    String? NomSite,
    String? AdresseSite,
    String? AnneeConstruction,
    String? Activite,
    double? SurfaceSHON,
    String? GTB_GTC,
    String? reseauTGBTetudie,
    String? typeSite,
  })=> Site(
    id:  id ?? this.id,
    typeSite: typeSite ?? this.typeSite,
    NomSite: NomSite ?? this.NomSite,
    AdresseSite: AdresseSite ?? this.AdresseSite,
    reseauTGBTetudie: reseauTGBTetudie ?? this.reseauTGBTetudie,
    SurfaceSHON: SurfaceSHON ?? this.SurfaceSHON,
    GTB_GTC:  GTB_GTC ?? this.GTB_GTC,
    Activite: Activite ?? this.Activite,
    AnneeConstruction:AnneeConstruction ?? this.AnneeConstruction,

  );

  Map<String,Object?> toJson() => {
    SiteFields.id: id,
    SiteFields.NomSite: NomSite,
    SiteFields.AdresseSite: AdresseSite,
    SiteFields.AnneeConstruction:AnneeConstruction,
    SiteFields.SurfaceSHON: SurfaceSHON,
    SiteFields.GTB_GTC: GTB_GTC,
    SiteFields.reseauTGBTetudie: reseauTGBTetudie,
    SiteFields.typeSite: typeSite,
  };

  static Site fromJson(Map<String,Object?> json) => Site(
    id: json[SiteFields.id] as int?,
    AdresseSite: json[SiteFields.AdresseSite] as String,
    NomSite: json[SiteFields.NomSite] as String,
    reseauTGBTetudie:  json[SiteFields.reseauTGBTetudie] as String,
    typeSite:  json[SiteFields.typeSite] as String,
    Activite:  json[SiteFields.Activite] as String,
    SurfaceSHON:  json[SiteFields.SurfaceSHON] as double,
    GTB_GTC:  json[SiteFields.GTB_GTC] as String,
    AnneeConstruction:  json[SiteFields.AnneeConstruction]as String ,

  );
}