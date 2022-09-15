import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/site_database.dart';
import '../db/Site_db.dart';
import 'Fiche_Etage.dart';


class FicheSite extends StatefulWidget {
  const FicheSite({Key? key}) : super(key: key);

  @override
  State<FicheSite> createState() => _FicheSiteState();
}

class _FicheSiteState extends State<FicheSite> {

  ///form key
  final _formFSKey = GlobalKey<FormState>();

  ///instance de Site qu'on cree
  late Site site ;

  ///variables utilisées
  late int nbEtage;
  late int nbBrEtage;


  ///dropdownItems_Type_Site
  String? SiteType = null ;
  List<DropdownMenuItem<String>> get dropdownItems_Type_Site {
    List<DropdownMenuItem<String>> STItems = [
      DropdownMenuItem(child: Text("Bâtiment"), value: "Bâtiment"),
      DropdownMenuItem(child: Text("Eclairage Publique"), value: "Eclairage Publique"),
      DropdownMenuItem(child: Text("Site Industriel"), value: "Site Industriel"),
      DropdownMenuItem(child: Text("Autre"), value: "Autre"),
    ];
    return STItems;
  }

  ///dropdownItems_Activite_Principale
  String? Activite_Principale_Value = null;
  List<DropdownMenuItem<String>> get dropdownItems_Activite_Principale {
    List<DropdownMenuItem<String>> APItems = [
      DropdownMenuItem(child: Text("Bureau"), value: "Bureau"),
      DropdownMenuItem(child: Text("Salle de Classe"), value: "Salle de Classe"),

    ];
    return APItems;
  }

  ///dropdownItems_Presence_GTB_GTC
  String? Presence_GTB_GTC = null;
  List<DropdownMenuItem<String>> get dropdownItems_Presence_GTB_GTC {
    List<DropdownMenuItem<String>> PGTBGTCItems = [
      DropdownMenuItem(child: Text("GTB"), value: "GTB"),
      DropdownMenuItem(child: Text("GTC"), value: "GTC"),
      DropdownMenuItem(child: Text("none"), value: "none"),
    ];
    return PGTBGTCItems;
  }

  ///dropdownItems_Annee_Construction
  static final now = DateTime.now().year;
  String? Annee_Construction = "$now";
  List<DropdownMenuItem<String>> get dropdownItems_Annee_Construction {

    List<DropdownMenuItem<String>> APItems = [];
    for(int i=0 ; i < 100 ;i++){
      int date = now-i;
      APItems.add(DropdownMenuItem(child: Text("$date"), value: "$date"));
    }
    return APItems;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nbEtage = 0;
    nbBrEtage = 0;
    ///initialiser l'instance du Site
    site = Site(
      id: 0,
      reseauTGBTetudie: '',
      GTB_GTC: '',
      AdresseSite: '',
      NomSite: '',
      AnneeConstruction: '',
      Activite: '',
      typeSite: '',
      SurfaceSHON: 0,
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Entete
          SizedBox(height: 30),
          ///title
          Center(
            child: Text(
              'Fiche Site',
              style: TextStyle(
                color: Color.fromRGBO(88, 89, 91, 1),
                fontWeight: FontWeight.normal,
                fontSize: 45,
                fontFamily: 'Prata',
              ),
            ),
          ),
          /*Row(
            children: [
              ///Return button replace by space

              /*IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.arrow_left_outlined),
                color: Color.fromRGBO(0, 102, 175, 1),
              ),*/
              ///title
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: Text(
                    'Fiche Site',
                    style: TextStyle(
                      color: Color.fromRGBO(88, 89, 91, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 45,
                      fontFamily: 'Prata',
                    ),
                  ),
                ),
              )
            ],
          ),*/
          Column(
            children: [
              Container(
                height: 15,
                color: Color.fromRGBO(193, 196, 198, .76),
              ),
              Container(
                height: 15,
                color: Color.fromRGBO(0, 102, 175, 1),
              ),
              Container(
                height: 15,
                color: Color.fromRGBO(247, 131, 27, 0.73),
              )
            ],
          ),
          SizedBox(height: 20),
          ///Body
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formFSKey,
                    child:  Column(
                      children: [
                        ///Nom site
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                site.NomSite = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir le nom du site ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nom Site',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(105, 103, 103, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(247, 131, 27, 0.73),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),

                            ),
                          ),
                        ),
                        ///Adresse
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                site.AdresseSite = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir l'adresse du site";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Adresse Site',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(105, 103, 103, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(247, 131, 27, 0.73),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),

                            ),
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ),
                        ///Type du Site
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Type du Site',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(105, 103, 103, 1),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(247, 131, 27, 0.73),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) =>
                              value == null
                                  ? "Veuillez saisir le type du Site"
                                  : null,
                              value: SiteType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  SiteType = newValue!;
                                  site.typeSite = SiteType!;
                                });
                              },
                              items: dropdownItems_Type_Site,
                          ),
                        ),
                        ///année de construction
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Année de Construction",
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(105, 103, 103, 1),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(247, 131, 27, 0.73),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) =>
                              value == null
                                  ? "Veuillez saisir l'année de construction"
                                  : null,
                              value: Annee_Construction,
                              onChanged: (String? newValue) {
                                setState(() {
                                  Annee_Construction = newValue!;
                                  site.AnneeConstruction = Annee_Construction!;
                                });
                              },
                              items: dropdownItems_Annee_Construction),
                        ),
                        ///activité principale
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Activité Principale',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(105, 103, 103, 1),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(247, 131, 27, 0.73),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) =>
                              value == null
                                  ? "Veuillez saisir votre activité principale"
                                  : null,
                              value: Activite_Principale_Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  Activite_Principale_Value = newValue!;
                                  site.Activite = Activite_Principale_Value!;
                                });
                              },
                              items: dropdownItems_Activite_Principale),
                        ),
                        ///Surface plancher du site
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  onChanged: (value){
                                    setState(() {
                                      site.SurfaceSHON = double.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir la surface du site ';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Surface plancher su site',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(105, 103, 103, 1),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(247, 131, 27, 0.73),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    //we choose singleLineFormatter to allow float numbers
                                    FilteringTextInputFormatter.singleLineFormatter
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              ///unité de mesure fixe
                              Container(
                                width: 65,
                                child: Flexible(
                                  child: TextFormField(
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    initialValue: "m²",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Veuillez saisir l'unité de mesure";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: '',
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(105, 103, 103, 1),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(247, 131, 27, 0.73),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///presence d'une GTB/GTC'+message d'information
                        Tooltip(
                          preferBelow: false,
                          message: 'GTB: Gestion Technique du Bâtiment \n GTC: Gestion Technique Centralisée',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ///Boutton Info
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset("assets/button_Images/icons_info.png" ,scale: 1.5,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      labelText: "Présence d'une GTB/GTC",
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(105, 103, 103, 1),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(247, 131, 27, 0.73),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) =>
                                    value == null
                                        ? "Veuillez saisir votre activité principale"
                                        : null,
                                    value: Presence_GTB_GTC,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        Presence_GTB_GTC = newValue!;
                                        site.GTB_GTC = Presence_GTB_GTC!;
                                      });
                                    },
                                    items: dropdownItems_Presence_GTB_GTC),
                              ),
                            ],
                          ),
                        ),
                        ///Réseau TGBT etudié
                        Tooltip(
                          preferBelow: false,
                          message: 'TGBT:  Tableau Général Basse Tension',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ///Boutton Info
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset("assets/button_Images/icons_info.png" ,scale: 1.5,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value){
                                    setState(() {
                                      site.reseauTGBTetudie = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir le nom du Réseau TGBT etudié';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Réseau/TGBT Etudié',
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(105, 103, 103, 1),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(247, 131, 27, 0.73),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///nombre d'étages/zones
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                nbEtage = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return SiteType == "Eclairage Publique" ? "Veuillez saisir le nombre de zones":"Veuillez saisir le nombre d'étages";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: SiteType == "Eclairage Publique" ? "nombre de zones":"nombre d'étages",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(105, 103, 103, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(247, 131, 27, 0.73),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        ///nombre de bureaux par étage / sous-espaces par zone
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                nbBrEtage = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return SiteType == "Eclairage Publique" ? "Veuillez saisir le nombre de sous espaces par zone":"Veuillez saisir le nombre de bureau par étage";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: SiteType == "Eclairage Publique" ? "nombre de sousEspace/zone":"nombre de bureau/étage",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(105, 103, 103, 1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(247, 131, 27, 0.73),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        ///button suivant
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 60,
                          width: 355,
                          child: ElevatedButton(
                            onPressed: (){
                              ///save data
                              if(_formFSKey.currentState!.validate()){
                                SiteDB.instance.createSite(site);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  FicheEtage(nbEtage: nbEtage,nbBrEtage: nbBrEtage, eclairage:SiteType == "Eclairage Publique")),
                                );
                              }
                            },
                            child: Text("Suivant"),
                            style:  ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1),),
                            ),
                          ),
                        ),
                        ///buttom Space
                        SizedBox(
                          height:20,
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
