import 'dart:math';
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

