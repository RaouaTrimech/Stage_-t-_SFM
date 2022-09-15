import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stage_ete/Affichage/Affich.dart';

import '../Model/zone_equipement_database.dart';
import '../Scan_Page.dart';
import '../db/Site_db.dart';

class InfoEquipement_ZM extends StatefulWidget {
  String ScannedID ;


  InfoEquipement_ZM( {Key? key , required this.ScannedID }) : super(key: key);

  @override
  State<InfoEquipement_ZM> createState() => _InfoEquipement_ZMState();
}

class _InfoEquipement_ZMState extends State<InfoEquipement_ZM> {

  final _formIEKey = GlobalKey<FormState>();

  bool isTaped = false ;

  late ZoneEquip zoneEquip ;

  final IdVoltixController = TextEditingController();

  @override
  void initState(){
    super.initState();
    IdVoltixController.text=widget.ScannedID;//retourner pour fixer apres
    zoneEquip = ZoneEquip(NomZone: '', IdBoltix: '');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Entete
          SizedBox(height: 30),
          Row(
            children: [
              //return button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.arrow_left_outlined),
                color: Color.fromRGBO(0, 102, 175, 1),
              ),
              //title
              Text(
                'Infos Equipements',
                style: TextStyle(
                  color: Color.fromRGBO(88, 89, 91, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 36,
                  fontFamily: 'Prata',
                ),
              )
            ],
          ),
          SizedBox(height: 5),
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
          //Zone Title
          Center(
            child: Text(
              'Nom de la Zone mesurée',
              style: TextStyle(
                color: Color.fromRGBO(0, 102, 175, 1),
                fontWeight: FontWeight.normal,
                fontSize: 30,
                fontFamily: 'Prata',
              ),
            ),
          ),
          SizedBox(height: 20),
          //Body
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formIEKey,
                    child:  Column(
                      children: [
                        //Nom de la Zone mesurée
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                zoneEquip.NomZone = value ;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir le nom de la Zone mesurée" ;
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Nom de la Zone mesurée",
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
                        ///Id Booster Voltix --->this field takes the scanned value
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Id Booster Voltix",
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
                                  ? "Veuillez saisir une activité principale"
                                  : null,
                              value: Id_Booster_Voltix,
                              onChanged: (String? newValue) {
                                setState(() {
                                  Id_Booster_Voltix = newValue!;
                                });
                              },
                              items: dropdownItems_Id_Booster_Voltix),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value){
                              setState(() {
                                zoneEquip.IdBoltix = value;
                              });
                            },
                            enableInteractiveSelection: false,
                            controller: IdVoltixController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez scanner l'id Voltix" ;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Id Booster Voltix",
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
                        ///Scanner Voltix
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          height: 60,
                          width: 355,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ScanPage()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.scanner_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Scanner VOLTIX',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Roboto',
                                  ),
                                )
                              ],
                            ),
                            style:  ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(249, 164, 89, 1),),
                            ),
                          ),
                        ),
                        ///sauvegarder réglements
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          height: 30,
                          width: 300,
                          child: ElevatedButton(
                            //save voltix

                            onPressed: (){
                              if(_formIEKey.currentState!.validate()){
                                SiteDB.instance.createZoneEquip(zoneEquip);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  const Affich()),
                                );
                              }

                            },
                            style:  ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 102, 175, 1),),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.save,
                                  color: Colors.white,

                                  size: 20,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Sauvegarder réglements',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                )
                              ],
                            ),
                          ),
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
