import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/equipement_database.dart';
import '../Model/horaire_occup_database.dart';
import '../Model/site_database.dart';
import '../Model/sous_espace_database.dart';
import '../Model/zone_equipement_database.dart';

class SiteDB {
  static final SiteDB instance = SiteDB._init();

  static Database? _database;

  SiteDB._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('Site.db');

    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath , filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);

  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER ';
    final stringType = 'VARCHAR NOT NULL';
    final arrayType = 'ARRAY[VARCHAR] NOT NULL';
    final integerType ='INTEGER NOT NULL';
    final floatType ='FLOAT NOT NULL';

    ///site_database.dart
    //////////////////////////////////
    await db.execute('''
    CREATE TABLE $tableSites(
    ${SiteFields.id} $idType,
    ${SiteFields.AdresseSite} $stringType,
    ${SiteFields.AnneeConstruction} $stringType,
    ${SiteFields.Activite} $stringType,
    ${SiteFields.SurfaceSHON} $floatType,
    ${SiteFields.GTB_GTC} $stringType,
    ${SiteFields.reseauTGBTetudie} $stringType,
    ${SiteFields.typeSite} $stringType,
    
    )
    ''');

    ///equipement_database.dart
    ///////////////////////////////////
    await db.execute('''
    CREATE TABLE $tableEquipements(
    ${EquipFields.id} $idType,
    ${EquipFields.NomEquipement} $stringType,
    ${EquipFields.TypeEquipement} $stringType,
    ${EquipFields.Puissance} $floatType,
    ${EquipFields.Marque} $stringType,
    ${EquipFields.Image} $stringType,
    ${EquipFields.Id_Etage} $intType,
    ${EquipFields.Id_SSE} $intType,
    )
    ''');

    ///horaire_occup_database.dart
    ///////////////////////////////////
    await db.execute('''
    CREATE TABLE $tableHorairesOccup(
    ${HoraireOccupFields.id} $idType,
    ${HoraireOccupFields.days} $arrayType,
    ${HoraireOccupFields.debutHour} $stringType,
    ${HoraireOccupFields.finHour} $stringType,
    ${HoraireOccupFields.id_SsE} $intType,
    FOREIGN KEY (${HoraireOccupFields.id_SsE}) REFERENCES $tableSousEspaces(id)
    )
    ''');

    ///sous_espace_database.dart
    ///////////////////////////////////
    await db.execute('''
    CREATE TABLE $tableSousEspaces(
    ${SousEspaceFields.id} $idType,
    ${SousEspaceFields.NomBureau} $stringType,
    ${SousEspaceFields.Surface} $floatType,
    ${SousEspaceFields.nbPersonne} $integerType,
    ${SousEspaceFields.IdEtage} $integerType,
    )
    ''');

    ///zone_equipement_database.dart
    ///////////////////////////////////
    await db.execute('''
    CREATE TABLE $tableZoneEquip(
    ${ZoneEquipFields.id} $idType,
    ${ZoneEquipFields.NomZone} $stringType,
    ${ZoneEquipFields.IdBoltix} $stringType,
    )
    ''');
    ///////////////////////////////////

  }


  /// CRUD Site
  Future<Site> createSite(Site site) async {
    final db = await instance.database;

    final id = await db.insert(tableSites, site.toJson());

    return site.copy(id: id);
  }

  Future<Site> readSite(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSites,
      columns: SiteFields.values,
      where: '${SiteFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Site.fromJson(maps.first);
    }else{
      throw Exception("ID $id n'existe pas");
    }
  }

  Future<List<Site>> readAllSites() async {
    final db = await instance.database;
    final result = await db.query(tableSites);
    ///converting the Map object to the Site objects
    return result.map((json)=> Site.fromJson(json)).toList();
  }

  Future<int> updateSite(Site site) async {
    final db = await instance.database;
    return db.update(tableSites,
      site.toJson(),
      where: '${SiteFields.id} = ?',
      whereArgs: [site.id],
    );
  }

  Future<int> deleteSite(int id) async {
    final db = await instance.database;
    return db.delete(tableSites,
      where: '${SiteFields.id} = ?',
      whereArgs: [id],
    );
  }

  /////////////////////////////////

  /// CRUD Equip
  Future<Equip> createEquip(Equip equip) async {
    final db = await instance.database;

    final id = await db.insert(tableEquipements, equip.toJson());

    return equip.copy(id: id);
  }

  Future<Equip> readEquip(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableEquipements,
      columns: EquipFields.values,
      where: '${EquipFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Equip.fromJson(maps.first);
    }else{
      throw Exception("ID $id n'existe pas");
    }
  }

  Future<List<Equip>> readAllEquips() async {
    final db = await instance.database;
    final result = await db.query(tableEquipements);
    ///converting the Map object to the Site objects
    return result.map((json)=> Equip.fromJson(json)).toList();
  }

  Future<List<Equip>> readEquipsEtage(int etage) async {
    final db = await instance.database;
    final result = await db.query(tableEquipements,
      where: '${EquipFields.Id_Etage} = ?',
      whereArgs: [etage],
    );
    return result.map((json)=> Equip.fromJson(json)).toList();
  }

  Future<int> updateEquip(Equip equip) async {
    final db = await instance.database;
    return db.update(tableEquipements,
      equip.toJson(),
      where: '${EquipFields.id} = ?',
      whereArgs: [equip.id],
    );
  }

  Future<int> deleteEquip(int id) async {
    final db = await instance.database;
    return db.delete(tableEquipements,
      where: '${EquipFields.id} = ?',
      whereArgs: [id],
    );
  }

  /////////////////////////////////

  /// CRUD Sous Espace
  Future<SsEspace> createSsEspace(SsEspace ssEspace) async {
    final db = await instance.database;

    final id = await db.insert(tableSousEspaces, ssEspace.toJson());

    return ssEspace.copy(id: id);
  }

  Future<SsEspace> readSsEspace(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSousEspaces,
      columns: SousEspaceFields.values,
      where: '${SousEspaceFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return SsEspace.fromJson(maps.first);
    }else{
      throw Exception("ID $id n'existe pas");
    }
  }

  Future<List<SsEspace>> readAllSsEspaces() async {
    final db = await instance.database;
    final result = await db.query(tableSousEspaces);
    ///converting the Map object to the Site objects
    return result.map((json)=> SsEspace.fromJson(json)).toList();
  }

  Future<List<SsEspace>> readSsEspacesEtage(int etage) async {
    final db = await instance.database;
    final result = await db.query(tableSousEspaces,
      where: '${EquipFields.Id_Etage} = ?',
      whereArgs: [etage],
    );
    ///converting the Map object to the Site objects
    return result.map((json)=> SsEspace.fromJson(json)).toList();
  }

  Future<int> updateSsEspace(SsEspace ssEspace) async {
    final db = await instance.database;
    return db.update(tableSousEspaces,
      ssEspace.toJson(),
      where: '${EquipFields.id} = ?',
      whereArgs: [ssEspace.id],
    );
  }

  Future<int> deleteSsEspace(int id) async {
    final db = await instance.database;
    return db.delete(tableSousEspaces,
      where: '${SousEspaceFields.id} = ?',
      whereArgs: [id],
    );
  }

  /////////////////////////////////

  /// CRUD Horaire_Occup
  Future<HoraireOccup> createHourOccup(HoraireOccup horaireOccup) async {
    final db = await instance.database;

    final id = await db.insert(tableHorairesOccup, horaireOccup.toJson());

    return horaireOccup.copy(id: id);
  }

  Future<HoraireOccup> readHourOccup(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableHorairesOccup,
      columns: HoraireOccupFields.values,
      where: '${HoraireOccupFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return HoraireOccup.fromJson(maps.first);
    }else{
      throw Exception("ID $id n'existe pas");
    }
  }

  Future<List<HoraireOccup>> readAllHourOccups() async {
    final db = await instance.database;
    final result = await db.query(tableHorairesOccup);
    ///converting the Map object to the Site objects
    return result.map((json)=> HoraireOccup.fromJson(json)).toList();
  }

  Future<int> updateHourOccup(HoraireOccup horaireOccup) async {
    final db = await instance.database;
    return db.update(tableHorairesOccup,
      horaireOccup.toJson(),
      where: '${HoraireOccupFields.id} = ?',
      whereArgs: [horaireOccup.id],
    );
  }

  Future<int> deleteHourOccup(int id) async {
    final db = await instance.database;
    return db.delete(tableHorairesOccup,
      where: '${HoraireOccupFields.id} = ?',
      whereArgs: [id],
    );
  }

  /////////////////////////////////
  /// CRUD ZoneEquip
  Future<ZoneEquip> createZoneEquip(ZoneEquip zoneEquip) async {
    final db = await instance.database;

    final id = await db.insert(tableSites, zoneEquip.toJson());

    return zoneEquip.copy(id: id);
  }

  Future<ZoneEquip> readZoneEquip(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableZoneEquip,
      columns: ZoneEquipFields.values,
      where: '${ZoneEquipFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return ZoneEquip.fromJson(maps.first);
    }else{
      throw Exception("ID $id n'existe pas");
    }
  }

  Future<List<ZoneEquip>> readAllZoneEquips() async {
    final db = await instance.database;
    final result = await db.query(tableZoneEquip);
    ///converting the Map object to the Site objects
    return result.map((json)=> ZoneEquip.fromJson(json)).toList();
  }

  Future<int> updateZoneEquip(ZoneEquip zoneEquip) async {
    final db = await instance.database;
    return db.update(tableZoneEquip,
      zoneEquip.toJson(),
      where: '${ZoneEquipFields.id} = ?',
      whereArgs: [zoneEquip.id],
    );
  }

  Future<int> deleteZoneEquip(int id) async {
    final db = await instance.database;
    return db.delete(tableZoneEquip,
      where: '${ZoneEquipFields.id} = ?',
      whereArgs: [id],
    );
  }

  /////////////////////////////////

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}