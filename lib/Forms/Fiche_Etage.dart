import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stage_ete/db/Site_db.dart';

import 'Fiche_SousEspace.dart';
//import '../Fiche_SousEspace1.dart';
import 'Info_Equip.dart';




class FicheEtage extends StatefulWidget {
  ///nombre de etage selectionnés
  int nbEtage ;
  ///nombre de bureau par étage
  int nbBrEtage;
  ///verifier si le type est eclairage publique ou pas
  bool eclairage;

  FicheEtage({Key? key, required this.nbEtage , required this.nbBrEtage, required this.eclairage}) : super(key: key);

  @override
  State<FicheEtage> createState() => _FicheEtageState();
}

class _FicheEtageState extends State<FicheEtage> {

  ///Form key
   late GlobalKey<FormState> _formFSKey  ;

  ///nombre de etage selectionnés
  late int _nbEtage;
  ///nombre de bureau par étage
  late int _nbBrEtage;
  ///verifier si le type est eclairage publique ou pas
  late bool _eclairage;

  ///pour controller scrolling
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  Future scrollToItem(int index) async {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 1)
    );

  }

  ///*-------Etage Stepper-------*///

    ///l'étape ective qui indique l'étage
    int activeStep = 0;

    ///la liste des sous_espaces à afficher
    List<SousEspace> ESE = [];

    ///la liste des nombres affichés pour les étages
    List<int> Numbers = [];
    List<int> buildEtageNumber(int n){
      for(int i=1 ; i<= n ;i++){
        Numbers.add(i);
      }
      return Numbers ;
    }

    ///créer la liste des étages/zones affichés
    void buildEtage(){
    if(ESE.isEmpty){
      for(int i = 0 ; i<_nbEtage ; i++){
        ESE.add(SousEspace(numEtage: i, nbEtage: _nbEtage,eclairage: _eclairage,nbBrEtage: _nbBrEtage, SSespace: [],));
      }
    }

    }

    ///afficher la liste des ss_espace d'un étage/Zone
    Widget showESE(int i){
      return ESE[i];
    }



  @override
  void initState() {

    _nbEtage = widget.nbEtage;
    _nbBrEtage = widget.nbBrEtage;
    _eclairage = widget.eclairage;
    activeStep= 0;
    _formFSKey = GlobalKey<FormState>();

    buildEtageNumber(_nbEtage);
    buildEtage();
    super.initState();

    ///listening to the etage number while scrolling
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .where((item) {
         final isTopVisible = item.itemLeadingEdge >=0;
         //final isBottomVisible = item.itemTrailingEdge<=1;

        //return isTopVisible && isBottomVisible;
        return isTopVisible ;
      })
          .map((item) => item.index).toList();

      ///changer la valeur de activeStep pour transferer while scrolling
      if(indices.isNotEmpty && activeStep != indices.first){
        setState((){
          activeStep =indices.first ;
        });
        print(' this is the indices : ${indices.first}');
      }
      ///écrire activeStep pour vérifier
      print(' this is the activeStep : $activeStep');
    });
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
          Row(
            children: [
              ///Return button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.arrow_left_outlined),
                color: Color.fromRGBO(0, 102, 175, 1),
              ),
              ///title
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                  'Fiche Etage',
                  style: TextStyle(
                    color: Color.fromRGBO(88, 89, 91, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 45,
                    fontFamily: 'Prata',
                  ),
                ),
              )
            ],
          ),
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
          
          ///affichage des numéros des étages
          NumberStepper(
            numbers: Numbers,
            activeStep: activeStep,
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
              scrollToItem(index);
            },
            activeStepColor: Color.fromRGBO(247, 131, 27, 0.73),
          ),
          SizedBox(height: 20),
          ///affichage de la liste des sous_espaces
          Form(
            key: _formFSKey,
            child: Expanded(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ESE.length,
                itemBuilder: (context, index) => showESE(index),
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          ),
          SizedBox(height: 20),
          ///Button Suivant --> return to add import
          Center(
            child: Container(
              height: 60,
              width: 355,
              child: ElevatedButton(
                onPressed: (){
                  if(_formFSKey.currentState!.validate()){
                    _formFSKey.currentState!.save();
                    ///save data for all the sous_espace ---> still not done
                    for(int i=0 ; i<ESE.length ; i++){
                      for(int j=0; j<ESE[i].SSespace.length ;j++){
                        SiteDB.instance.createSsEspace(ESE[i].SSespace[j]);
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  InfoEquipement(index: 0,nbEtage: _nbEtage, nbBrEtage: _nbBrEtage,)),
                    );
                  }else{
                    print('Noooooo');
                  }
                },

                child: Text("Suivant"),
                style:  ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1),),
                ),
              ),
            ),
          ),
          ///buttom Space
          SizedBox(
            height:20,
          ),
        ],
      ),
    );
  }
}
