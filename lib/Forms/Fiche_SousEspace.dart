/*import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Horaires_Occup.dart';



class SousEspace extends StatefulWidget {
  
  ///le nombre d'étages
  int nbEtage ;
  ///le numéro du étage concerné
  int numEtage;
  ///le nombre de bureau par étage
  int nbBrEtage;
  ///indique s'il s'git d'un étage ou d'une zone
  bool eclairage;

  SousEspace({Key? key,required this.numEtage,required this.nbEtage,required this.eclairage, required this.nbBrEtage}) : super(key: key);

  @override
  State<SousEspace> createState() => _SousEspaceState();
}

class _SousEspaceState extends State<SousEspace> {

  late GlobalKey<FormState> _formFSKey ;

  ///indique le sous-espace affiché d'une étage
  int currentStepSE = 0;
  ///la fiche des sous_espaces par étage
  List<Step> SE = [];
  ///le nombre d'étages
  int _nbEtage =0;
  ///le nombre de bureau par étage
  int _nbBrEtage =0;
  ///indique s'il s'git d'un étage ou d'une zone
  bool _eclairage = false;

  ///dropdownItems_Nom_Etage / dropdownItems_Nom_Zone
  String? Nom_Etage = "Rez de chaussé";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_Etage {

    List<DropdownMenuItem<String>> EtaItems = [];

    EtaItems.add(DropdownMenuItem(child: Text("Rez de chaussé"), value: "Rez de chaussé"));

    for(int i=1 ; i <= _nbEtage ;i++){
      EtaItems.add(DropdownMenuItem(child: Text("$i Etage"), value: "$i Etage"));
    }
    return EtaItems;
  }
  List<DropdownMenuItem<String>> get dropdownItems_Nom_Zone {

    List<DropdownMenuItem<String>> ZaItems = [];

    for(int i=1 ; i <= _nbEtage ;i++){
      ZaItems.add(DropdownMenuItem(child: Text("$i Espace"), value:"$i Espace"));
    }
    return ZaItems;
  }

  ///dropdownItems_Nom_SousEspace
  String? Nom_SousEspace = "Bureau 1";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_SousEspace {

    List<DropdownMenuItem<String>> SEItems = [];

    for(int i=1 ; i <= _nbBrEtage ;i++){
      SEItems.add(DropdownMenuItem(child: Text("Bureau $i"), value: "Bureau $i"));
    }
    return SEItems;
  }


  @override
  void initState() {
    _nbEtage = widget.nbEtage;
    _eclairage = widget.eclairage;
    _nbBrEtage = widget.nbBrEtage;
    _formFSKey = GlobalKey<FormState>();
    SE.add(buildSousEspace(0));
    super.initState();

  }



  ///----> revenir pour regler l'import
  Step buildSousEspace(int i){
    GlobalKey<FormState> _formSEKey = GlobalKey<FormState>();
    return Step(
      title: Text('Sous-espace :'),
      content: Form(
        key: _formSEKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Sous-Espace
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Sous-espace",
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
                  validator: (value) => value == null ? "Veuillez saisir le sous-espace" : null,
                  value: Nom_SousEspace,
                  onChanged: (String? newValue) {
                    setState(() {
                      Nom_SousEspace = newValue!;
                    });
                  },
                  items: dropdownItems_Nom_SousEspace),
            ),
            ///Surface
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez saisir la surface du sous-espace";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Surface",
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
            ///nombre de Personnes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez saisir le nombre de personnes";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "nombre de personnes",
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
            ///Heures d'occupations
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Horaires_Occup(
                id_SSE: 0, ///change it to the right id after creating sous Espaces
                wid: TextFormField(
                  readOnly: true,
                  enabled: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez saisir les horaires d'occupations";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Heures d'occupations",
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
                    disabledBorder: OutlineInputBorder(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          padding: EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Form(
              key: _formFSKey,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Nom Etage
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Nom Etage",
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(105, 103, 103, 1),
                                width: 1.5
                            ),
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
                            ? "Veuillez saisir le nom de l'etage"
                            : null,
                        value: Nom_Etage,
                        onChanged: (String? newValue) {
                          setState(() {
                            Nom_Etage = newValue!;
                          });
                        },
                        items: dropdownItems_Nom_Etage),
                  ),
                  ///Titre sous-espaces
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Les sous-espaces:",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 102, 175, 1),
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: 'Prata',
                      ),
                    ),
                  ),
                  ///Sous-Espace
                  Theme(
                    data:Theme.of(context).copyWith(
                      colorScheme:  ColorScheme.light(
                        primary: Color.fromRGBO(0, 102, 175, 1),
                        background: Color.fromRGBO(193, 196, 198, .76),
                        secondary: Color.fromRGBO(0, 102, 175, 1),
                      ),
                    ),
                    child: Stepper(
                      //we use the key to be able to update the stepper length
                      key: Key(Random.secure().nextDouble().toString()),
                      currentStep: currentStepSE,
                      onStepTapped: (index) {
                        setState(() => currentStepSE = index);
                      },
                      steps: SE,
                      //to enable the scolling in the stepper
                      physics: ClampingScrollPhysics(),
                      controlsBuilder: (context, _){
                        return Column(
                          children: [
                            //bouton Ajouter sous-espaces
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 35,
                              width: 355,
                              child: ElevatedButton(
                                onPressed: (){
                                  //ajouter un sous-espace
                                  setState(() {
                                    SE.add(buildSousEspace(SE.length));
                                    currentStepSE = SE.length-1;
                                  });
                                },
                                child: Text("Ajouter un sous-espace"),
                                style:  ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(247, 131, 27, 0.73),),
                                ),
                              ),
                            ),
                            //bouton supprimer sous-espaces
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 35,
                              width: 355,
                              child: ElevatedButton(
                                onPressed: (){
                                  if(currentStepSE == SE.length -1){

                                    if(SE.length == 1){
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Erreur"),
                                          content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(14),
                                                child: const Text("ok"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        SE.removeLast();
                                      });
                                    }

                                  }
                                  else if(currentStepSE == 0){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Erreur"),
                                        content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("ok"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    if(SE.length == 1){
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Erreur"),
                                          content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(14),
                                                child: const Text("ok"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }else{
                                      //supprimer un sous-espace
                                      setState(() {
                                        SE.removeAt(currentStepSE);
                                      });
                                    }

                                  }
                                },
                                child: Text("Supprimer un sous-espace"),
                                style:  ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(182, 60, 21, 1),),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Color.fromRGBO(247, 131, 27, 0.73),
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}



 */


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/sous_espace_database.dart';
import 'Horaires_Occup.dart';
import 'package:stage_ete/globals.dart' as globals;


class SousEspace extends StatefulWidget {

  ///le nombre d'étages
  int nbEtage ;
  ///le numéro du étage concerné
  int numEtage;
  ///le nombre de bureau par étage
  int nbBrEtage;
  ///indique s'il s'git d'un étage ou d'une zone
  bool eclairage;
  List<SsEspace> SSespace = [];

  SousEspace({Key? key,required this.numEtage,required this.nbEtage,required this.eclairage, required this.nbBrEtage,required this.SSespace}) : super(key: key);

  @override
  State<SousEspace> createState() => _SousEspaceState();
}

class _SousEspaceState extends State<SousEspace> {


  ///indique le sous-espace affiché d'une étage
  int currentStepSE = 0;
  ///la fiche des sous_espaces par étage
  List<Step> SE = [];
  ///le nombre d'étages
  int _nbEtage =0;
  ///le nombre de bureau par étage
  int _nbBrEtage =0;
  ///le numero de l'étage
  int _numEtage = 0;
  ///indique s'il s'git d'un étage ou d'une zone
  bool _eclairage = false;

  ///dropdownItems_Nom_Etage / dropdownItems_Nom_Zone
  String? Nom_Etage = "Rez de chaussé";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_Etage {

    List<DropdownMenuItem<String>> EtaItems = [];

    EtaItems.add(DropdownMenuItem(child: Text("Rez de chaussé"), value: "Rez de chaussé"));

    for(int i=1 ; i < _nbEtage ;i++){
      EtaItems.add(DropdownMenuItem(child: Text("$i Etage"), value: "$i Etage"));
    }
    return EtaItems;
  }
  List<DropdownMenuItem<String>> get dropdownItems_Nom_Zone {

    List<DropdownMenuItem<String>> ZaItems = [];

    for(int i=1 ; i < _nbEtage ;i++){
      ZaItems.add(DropdownMenuItem(child: Text("$i Espace"), value:"$i Espace"));
    }
    return ZaItems;
  }

  ///dropdownItems_Nom_SousEspace
  String? Nom_SousEspace = "Bureau 1";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_SousEspace {

    List<DropdownMenuItem<String>> SEItems = [];

    for(int i=1 ; i <= _nbBrEtage ;i++){
      SEItems.add(DropdownMenuItem(child: Text("Bureau $i"), value: "Bureau $i"));
    }
    return SEItems;
  }

  ///List Selected or not
  late List<String> Select_Loc ;

  @override
  void initState() {
    _nbEtage = widget.nbEtage;
    _numEtage  = widget.numEtage;
    _eclairage = widget.eclairage;
    _nbBrEtage = widget.nbBrEtage;
    Select_Loc = globals.selected;
    SE.add(buildSousEspace(0));
    super.initState();

  }
/*
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Horaires_Occup(wid: wid, id_SSE: id_SSE)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

*/
  
  String txt(int i){
    return globals.selected[i];
  }
  
Step buildSousEspace(int i){

    globals.selected.add('NotSet');
    SsEspace ssE = SsEspace(NomBureau: '', Surface: 0, nbPersonne: 0, NomEtage: _numEtage);
    widget.SSespace.add(ssE);
    int pos = widget.SSespace.indexOf(ssE);

     TextEditingController Sur = new TextEditingController();
     TextEditingController nbP = new TextEditingController();
     //TextEditingController Hor = new TextEditingController(text: txt(i));
      //print(' Select_Loc[i]${ Select_Loc[i]}');


    return Step(
      title: Text('Sous-espace :'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Sous-Espace
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Sous-espace",
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
                validator: (value) => value == null ? "Veuillez saisir le sous-espace" : null,
                value: Nom_SousEspace,
                onChanged: (String? newValue) {
                  setState(() {
                    Nom_SousEspace = newValue!;
                    widget.SSespace.elementAt(pos).NomBureau = Nom_SousEspace!;
                  });
                },
                items: dropdownItems_Nom_SousEspace),

          ),
          ///Surface
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: Sur,
              onSaved: (value){
                setState(() {
                  widget.SSespace.elementAt(pos).Surface = double.parse(value!);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir la surface du sous-espace";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Surface",
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
          ///nombre de Personnes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nbP,
              onSaved: (value){
                setState(() {
                  widget.SSespace.elementAt(pos).nbPersonne = int.parse(value!);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir le nombre de personnes";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "nombre de personnes",
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
          ///Heures d'occupations
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Horaires_Occup(
              id_SSE:pos,
              select: i,
              wid: TextFormField(
                initialValue: '--------',
                readOnly: true,
                enabled: false,

                validator: (value) {
                  if (Select_Loc[i] == 'NotSet') {
                    return "Veuillez saisir les horaires d'occupations";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Heures d'occupations",
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
                  disabledBorder: OutlineInputBorder(
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
    );
  }
  ///----> revenir pour regler l'import
  /*Step buildSousEspace(int i){

    return Step(
      title: Text('Sous-espace :'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Sous-Espace
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Sous-espace",
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
                validator: (value) => value == null ? "Veuillez saisir le sous-espace" : null,
                value: Nom_SousEspace,
                onChanged: (String? newValue) {
                  setState(() {
                    Nom_SousEspace = newValue!;
                  });
                },
                items: dropdownItems_Nom_SousEspace),
          ),
          ///Surface
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir la surface du sous-espace";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Surface",
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
          ///nombre de Personnes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir le nombre de personnes";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "nombre de personnes",
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
          ///Heures d'occupations
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Horaires_Occup(
              id_SSE: 0, ///change it to the right id after creating sous Espaces
              wid: TextFormField(
                readOnly: true,
                enabled: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez saisir les horaires d'occupations";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Heures d'occupations",
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
                  disabledBorder: OutlineInputBorder(
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
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          padding: EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Nom Etage
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Nom Etage",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(105, 103, 103, 1),
                              width: 1.5
                          ),
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
                          ? "Veuillez saisir le nom de l'etage"
                          : null,
                      value: Nom_Etage,
                      onChanged: (String? newValue) {
                        setState(() {
                          Nom_Etage = newValue!;
                        });
                      },
                      items: dropdownItems_Nom_Etage),
                ),
                ///Titre sous-espaces
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Les sous-espaces:",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 102, 175, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: 'Prata',
                    ),
                  ),
                ),
                ///Sous-Espace
                Theme(
                  data:Theme.of(context).copyWith(
                    colorScheme:  ColorScheme.light(
                      primary: Color.fromRGBO(0, 102, 175, 1),
                      background: Color.fromRGBO(193, 196, 198, .76),
                      secondary: Color.fromRGBO(0, 102, 175, 1),
                    ),
                  ),
                  child: Stepper(
                    ///we use the key to be able to update the stepper length
                    key: Key(Random.secure().nextDouble().toString()),
                    currentStep: currentStepSE,
                    onStepTapped: (index) {
                      setState(() => currentStepSE = index);
                    },
                    steps: SE,
                    ///to enable the scolling in the stepper
                    physics: ClampingScrollPhysics(),
                    controlsBuilder: (context, _){
                      return Column(
                        children: [
                          ///bouton Ajouter sous-espaces
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 35,
                            width: 355,
                            child: ElevatedButton(
                              onPressed: (){
                                ///ajouter un sous-espace
                                setState(() {
                                  SE.add(buildSousEspace(SE.length));

                                  currentStepSE = SE.length-1;
                                });
                              },
                              child: Text("Ajouter un sous-espace"),
                              style:  ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(247, 131, 27, 0.73),),
                              ),
                            ),
                          ),
                          ///bouton supprimer sous-espaces
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 35,
                            width: 355,
                            child: ElevatedButton(
                              onPressed: (){
                                if(currentStepSE == SE.length -1){

                                  if(SE.length == 1){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Erreur"),
                                        content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("ok"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    setState(() {
                                      globals.selected.removeLast();
                                      SE.removeLast();
                                    });
                                  }

                                }
                                else if(currentStepSE == 0){
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Erreur"),
                                      content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("ok"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }else{
                                  if(SE.length == 1){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Erreur"),
                                        content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("ok"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    ///supprimer un sous-espace
                                    setState(() {
                                      globals.selected.removeAt(currentStepSE);
                                      SE.removeAt(currentStepSE);
                                    });
                                  }

                                }
                              },
                              child: Text("Supprimer un sous-espace"),
                              style:  ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(182, 60, 21, 1),),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Color.fromRGBO(247, 131, 27, 0.73),
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}


/*
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/sous_espace_database.dart';
import 'Horaires_Occup.dart';



class SousEspace extends StatefulWidget {
  int nbEtage ;
  int numEtage;
  bool eclairage;
  List<SsEspace> SSespace = [];
  SousEspace({Key? key,required this.numEtage,required this.nbEtage,required this.eclairage,required this.SSespace}) : super(key: key);

  @override
  State<SousEspace> createState() => _SousEspaceState();
}

class _SousEspaceState extends State<SousEspace> {

  int currentStepSE = 0;
  List<Step> SE = [];

  int _nbEtage =0;
  int _numEtage=0;
  bool _eclairage = false;

  @override
  void initState() {

    _nbEtage = widget.nbEtage;
    _numEtage = widget.numEtage;
    _eclairage = widget.eclairage;

    SE.add(buildSousEspace(0));
    super.initState();

  }

  String? Nom_Etage = "Rez de chaussé";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_Etage {

    List<DropdownMenuItem<String>> EtaItems = [];

    EtaItems.add(DropdownMenuItem(child: Text("Rez de chaussé"), value: "Rez de chaussé"));

    for(int i=1 ; i <= _nbEtage ;i++){
      EtaItems.add(DropdownMenuItem(child: Text("$i Etage"), value: "$i Etage"));
    }
    return EtaItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems_Nom_Zone {

    List<DropdownMenuItem<String>> ZaItems = [];

    for(int i=1 ; i <= _nbEtage ;i++){
      ZaItems.add(DropdownMenuItem(child: Text("$i Espace"), value:"$i Espace"));
    }
    return ZaItems;
  }

  String? Nom_SousEspace = "Bureau 1";
  List<DropdownMenuItem<String>> get dropdownItems_Nom_SousEspace {

    List<DropdownMenuItem<String>> SEItems = [];
    //--> pour le moment je vais laisser 4 mais a changer
    for(int i=1 ; i <= 4 ;i++){
      SEItems.add(DropdownMenuItem(child: Text("Bureau $i"), value: "Bureau $i"));
    }
    return SEItems;
  }

  Step buildSousEspace(int i){

    SsEspace ssE = SsEspace(NomBureau: '', Surface: 0, nbPersonne: 0, NomEtage: _numEtage);
    widget.SSespace.add(ssE);
    int pos = widget.SSespace.indexOf(ssE);
    return Step(
      title: Text('Sous-espace :'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Sous-Espace
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Sous-espace",
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
                validator: (value) => value == null ? "Veuillez saisir le sous-espace" : null,
                value: Nom_SousEspace,
                onChanged: (String? newValue) {
                  setState(() {
                    Nom_SousEspace = newValue!;
                    widget.SSespace.elementAt(pos).NomBureau = Nom_SousEspace!;
                  });
                },
                items: dropdownItems_Nom_SousEspace),
          ),
          ///Surface
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  widget.SSespace.elementAt(pos).Surface = double.parse(value!);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir la surface du sous-espace";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Surface",
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
          ///nombre de Personnes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  widget.SSespace.elementAt(pos).nbPersonne = int.parse(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez saisir le nombre de personnes";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "nombre de personnes",
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
          ///Heures d'occupations
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Horaires_Occup(
              id_SSE:pos,
              wid: TextFormField(
                readOnly: true,
                enabled: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez saisir les horaires d'occupations";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Heures d'occupations",
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
                  disabledBorder: OutlineInputBorder(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.blueAccent),
            //border: Border(top: BorderSide(color: Colors.blueAccent)),
          ),
          padding: EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Nom Etage
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Nom Etage",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(105, 103, 103, 1),
                              width: 1.5
                          ),
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
                          ? "Veuillez saisir le nom de l'etage"
                          : null,
                      value: Nom_Etage,
                      onChanged: (String? newValue) {
                        setState(() {
                          Nom_Etage = newValue!;
                        });
                      },
                      items: dropdownItems_Nom_Etage),
                ),
                ///Titre sous-espaces
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Les sous-espaces:",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 102, 175, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: 'Prata',
                    ),
                  ),
                ),
                //Sous-Espace
                Theme(
                  data:Theme.of(context).copyWith(
                    colorScheme:  ColorScheme.light(
                      primary: Color.fromRGBO(0, 102, 175, 1),
                      background: Color.fromRGBO(193, 196, 198, .76),
                      secondary: Color.fromRGBO(0, 102, 175, 1),
                    ),
                  ),
                  child: Stepper(
                    //we use the key to be able to update the stepper length
                    key: Key(Random.secure().nextDouble().toString()),
                    currentStep: currentStepSE,
                    onStepTapped: (index) {
                      setState(() => currentStepSE = index);
                    },
                    steps: SE,
                    //to enable the scolling in the stepper
                    physics: ClampingScrollPhysics(),
                    controlsBuilder: (context, _){
                      return Column(
                        children: [
                          //bouton Ajouter sous-espaces
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 35,
                            width: 355,
                            child: ElevatedButton(
                              onPressed: (){
                                //ajouter un sous-espace
                                setState(() {
                                  SE.add(buildSousEspace(SE.length));
                                  currentStepSE = SE.length-1;
                                });
                              },
                              child: Text("Ajouter un sous-espace"),
                              style:  ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(247, 131, 27, 0.73),),
                              ),
                            ),
                          ),
                          //bouton supprimer sous-espaces
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 35,
                            width: 355,
                            child: ElevatedButton(
                              onPressed: (){
                                if(currentStepSE == SE.length -1){

                                  if(SE.length == 1){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Erreur"),
                                        content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("ok"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    setState(() {
                                      SE.removeLast();
                                    });
                                  }

                                }
                                else if(currentStepSE == 0){
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Erreur"),
                                      content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("ok"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }else{
                                  if(SE.length == 1){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Erreur"),
                                        content: const Text("Vous devez avoir au moins 1 sous-espace"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              child: const Text("ok"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    //supprimer un sous-espace
                                    setState(() {
                                      SE.removeAt(currentStepSE);
                                    });
                                  }

                                }
                              },
                              child: Text("Supprimer un sous-espace"),
                              style:  ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(182, 60, 21, 1),),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                //button suivant
                /*Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 60,
                    width: 355,
                    child: ElevatedButton(
                      onPressed: (){
                        //save data
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  InfoEquipement(index: 1,)),
                        );
                      },
                      child: Text("Suivant"),
                      style:  ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1),),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Color.fromRGBO(247, 131, 27, 0.73),
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}

*/