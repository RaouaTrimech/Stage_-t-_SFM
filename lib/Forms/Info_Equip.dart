import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' ;

import '../Model/equipement_database.dart';
import '../Model/sous_espace_database.dart';
import '../db/Site_db.dart';
import 'Infos_Equipements_ZM.dart';

class InfoEquipement extends StatefulWidget {
  ///indice de l'équipement (nb de pages pour l'equipement )
  int index;
  ///le nombre total d'étages
  int nbEtage;
  InfoEquipement({Key? key, required this.index, required this.nbEtage, }) : super(key: key);

  @override
  State<InfoEquipement> createState() => _InfoEquipementState();
}

class _InfoEquipementState extends State<InfoEquipement> {

  ///indice de l'équipement
  int? _index ;
  ///l'instace de l'équipement à crée
  late Equip equip;
  ///le nombre total d'étages
  late int _nbEtage;
  ///la liste de tous les bureau dans le site
  List<SsEspace> bureauSE = [];
  bool isLoading = false;


  List<Widget> nbEtageWidget = [];

  void initState(){
    _index = widget.index;
    _nbEtage = widget.nbEtage;
    ///----->rectifier l'id_Etage et l'id_SSE
    equip = Equip(
        id: _index,
        NomEquipement: '',
        TypeEquipement: '',
        Puissance: 0,
        Marque: '',
        Image: '', Id_Etage: 0, Id_SSE: 0);

    nbEtageWidget.add(buildNbEtageBureau());

    refreshSSe();

  }

  /// recuperer la liste de ss-espaces dans la BD
  Future refreshSSe() async {
    setState(() {
      isLoading = true ;
    });

    this.bureauSE = await SiteDB.instance.readAllSsEspaces() ;

    setState(() {
      isLoading = true ;
    });

  }

  Map<String,String> EquipIcons = {
    'Chauffage,Climatisation' : 'assets/Equipements/ChauffageClimatisation.png' ,
    'Eclairage' :'assets/Equipements/Eclairage.png' ,
    'Onduleurs' : 'assets/Equipements/Onduleurs.png' ,
    'Cuisine' : 'assets/Equipements/Cuisine.png' ,
    'Informatique' : 'assets/Equipements/Informatique.png',
    'Autre équipements' : 'assets/Equipements/Autre.png'
  };

  final _formIEKey = GlobalKey<FormState>();
  bool isTaped = false ;


  String? Type_Equipement = null;
  List<DropdownMenuItem<String>> get dropdownItems_Type_Equipement {
    List<DropdownMenuItem<String>> TEItems = [
      //DropdownMenuItem(child: Text("Chauffage,Climatisation"), value: "Chauffage,Climatisation"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/ChauffageClimatisation.png'),
          Text("Chauffage,Climatisation"),
        ],
      ), value: "Chauffage,Climatisation"),
      //DropdownMenuItem(child: Text("Eclairage"), value: "Eclairage"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/Eclairage.png'),
          Text("Eclairage"),
        ],
      ), value: "Eclairage"),
      //DropdownMenuItem(child: Text("Onduleurs"), value: "Onduleurs"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/Onduleurs.png'),
          Text("Onduleurs"),
        ],
      ), value: "Onduleurs"),
      //DropdownMenuItem(child: Text("Cuisine"), value: "Cuisine"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/Cuisine.png'),
          Text("Cuisine"),
        ],
      ), value: "Cuisine"),
      //DropdownMenuItem(child: Text("Informatique"), value: "Informatique"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/Informatique.png'),
          Text("Informatique"),
        ],
      ), value: "Informatique"),
      //DropdownMenuItem(child: Text("Autre équipements"), value: "Autre équipements"),
      DropdownMenuItem(child: Row(
        children: [
          Image.asset('assets/Equipements/Autre.png'),
          Text("Autre équipements"),
        ],
      ), value: "Autre équipements"),
    ];
    return TEItems;
  }

  String? Num_Etage = null;
  List<DropdownMenuItem<String>> get dropdownItems_Num_Etage {
    List<DropdownMenuItem<String>> NEItems = [];

    NEItems.add(DropdownMenuItem(child: Text("Rez de chaussé",style: TextStyle(fontSize: 15),), value: "Rez de chaussé"));
    for(int i=1 ; i < _nbEtage ;i++){
      NEItems.add(DropdownMenuItem(child: Text("$i Etage",style: TextStyle(fontSize: 15),), value: "$i Etage"));
    }
    return NEItems;
  }

  String? Num_Bureau = null;
  List<DropdownMenuItem<String>> get dropdownItems_Num_Bureau {
    List<DropdownMenuItem<String>> NBItems = [];
    for(int i=1 ; i <= _nbEtage ;i++){
      NBItems.add(DropdownMenuItem(child: Text("$i Bureau",style: TextStyle(fontSize: 15),), value: "$i Bureau"));
    }
    return NBItems;
  }


  ///*------ Image Field ------*///
  final ImageController = TextEditingController();
  File? image ;

  Future pickImage(ImageSource source) async {

    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return ;
      //final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);

      setState(() {
        //this.image = imageTemporary;
        this.image = imagePermanent;
        ImageController.text = image.path.toString() ;
      });
    } on PlatformException catch ( e){
      print('Failed to pick image: $e');
    }


  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if(Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () => () => Navigator.of(context).pop(ImageSource.camera),
                child: Text('Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () => () => Navigator.of(context).pop(ImageSource.gallery),
                child: Text('Gallery'),
              ),
            ],
          )
      );
    }else{
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:Icon(Icons.camera_alt_outlined),
                title: Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading:Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          )
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildNbEtageBureau(){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///nombre d'équipements
          Container(
            width: (window.physicalSize.width)/10,
            child: Flexible(
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir la surface du site ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Surface plancher su site(SHON)',
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
          ),
          ///Num_étage
          Container(
            width: (window.physicalSize.width)/10,
            child: DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: "n° Etage",
                  labelStyle: TextStyle(
                    fontSize: 15,
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
                    ? "Veuillez saisie le numéro de l'étage"
                    : null,
                value: Num_Etage,
                onChanged: (String? newValue) {
                  setState(() {
                    Num_Etage = newValue!;
                  });
                },
                items: dropdownItems_Num_Etage),
          ),
          Container(
            width: (window.physicalSize.width)/10,
            child: Flexible(
              child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: "n° Bureau",
                    labelStyle: TextStyle(
                      fontSize: 15,
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
                      ? "Veuillez saisie le numéro du bureau"
                      : null,
                  value: Num_Bureau,
                  onChanged: (String? newValue) {
                    setState(() {
                      Num_Bureau = newValue!;
                    });
                  },
                  items: dropdownItems_Num_Bureau),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Entete
          SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.arrow_left_outlined),
                color: Color.fromRGBO(0, 102, 175, 1),
              ),
              Text(
                'Infos Equipements',
                style: TextStyle(
                  color: Color.fromRGBO(88, 89, 91, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 35,
                  fontFamily: 'Prata',
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          //Header decoration
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
          //Body
          //show_image
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(247, 131, 27, .73),
                width: 2,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.fill,
              child: image != null ? Image.file(image!) : Image.asset('assets/Equipements/DefaultImage.png') ,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Form(
                  key: _formIEKey,
                  child:  Column(
                    children: [
                      //Nom et Usage de l'équipement
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value){
                            setState(() {
                              equip.NomEquipement = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez saisir le nom de l'équipement et son usage" ;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Nom et Usage de l'équipement",
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
                      //Type d'équipement
                      ///change the name etage based on the Site type after
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: "Type d'équipement",
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
                                ? "Veuillez saisie le nom de 'étage"
                                : null,
                            value: Type_Equipement,
                            onChanged: (String? newValue) {
                              setState(() {
                                Type_Equipement = newValue!;
                                equip.TypeEquipement = Type_Equipement!;
                              });
                            },
                            items: dropdownItems_Type_Equipement),
                      ),
                      //Image de l'équipement
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value){
                                    setState(() {
                                      equip.Image = value;
                                    });
                                  },
                                  readOnly: true,
                                  controller: ImageController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir une image';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Image de l'equipement",
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
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              width: 70,
                              child: Flexible(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1)),
                                      ) ,
                                      onPressed: () async {
                                        final source = await showImageSource(context);

                                        if (source == null) return ;

                                        pickImage(source);
                                      },
                                      child: Text(
                                        'prendre une image',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Marque
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value){
                            setState(() {
                              equip.Marque = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez saisir la marque de l'équipement" ;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Marque de l'équipement",
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
                      //Puissance d'équipement
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value){
                            setState(() {
                              equip.Puissance=double.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez saisir la puissance de l'équipement";
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            labelText: "Puissance d'équipement",
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
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                        ),
                      ),
                      //List of Nombre d'équipement/etage/bureau
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: nbEtageWidget.length,
                          itemBuilder:(context,index){
                            return Dismissible(
                              movementDuration: Duration(milliseconds: 30),
                              secondaryBackground: Container(
                                color: Color.fromRGBO(193, 196, 198, .76),
                              ),
                              background: Container(
                                color: Color.fromRGBO(193, 196, 198, .76),
                              ),
                              key: UniqueKey(),
                              direction: (nbEtageWidget.length ==1)?DismissDirection.none: DismissDirection.horizontal,
                              child: ListTile(
                                title: nbEtageWidget[index],
                              ),
                              onDismissed: (direction){
                                setState(() {
                                  nbEtageWidget.removeAt(index);
                                });
                              },
                            );
                          }
                      ),

                      ///ajouter ligne button
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom:20),
                        height: 17,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              nbEtageWidget.add(buildNbEtageBureau());
                            });
                          },
                          child: Text("Ajouter +"),
                          style:  ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(247, 131, 27, 0.73),),
                          ),
                        ),
                      ),

                      ///Suivant button
                      Container(
                        margin: EdgeInsets.only(top: 20,bottom:100),
                        height: 50,
                        width: 320,
                        child: ElevatedButton(
                          onPressed: (){
                            //save the last equip
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>   InfoEquipement_ZM(ScannedID: '',),
                                ));
                          },
                          child: Text("Sauvegarder Equipements"),
                          style:  ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                )
            ),
          ),

        ],
      ),
      floatingActionButton: //Add/remove Button
      (isTaped) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Add
          FloatingActionButton(
            onPressed: () {
              //save equipement
              SiteDB.instance.createEquip(equip);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  InfoEquipement(index: _index!+1,nbEtage: _nbEtage,)),
              );
            },
            backgroundColor: Color.fromRGBO(40, 172, 45, 1),
            child: Image.asset('assets/button_Images/Plus.png') ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          //remove
          FloatingActionButton(
            onPressed: () {
              if(_index == 0){
                _scaffoldKey.currentState?.showSnackBar(
                  SnackBar(
                    backgroundColor: Color.fromRGBO(0, 102, 175, 1),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon( Icons.warning_rounded,color: Colors.white,),
                        Text('Vous devez au moins avoir 1 équipement'),
                      ],
                    ),
                    duration: Duration(seconds: 3),
                  ),
                );
              }else{
                //delete in the db
                Navigator.pop(context);
              }
            },
            backgroundColor: Color.fromRGBO(182, 60, 21, 1),
            child: Image.asset('assets/button_Images/Delete.png') ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          //activate button
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isTaped = !isTaped;
              });
            },
            backgroundColor: Color.fromRGBO(0, 102, 175, 1),
            child: Image.asset('assets/button_Images/Services.png') ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ) : FloatingActionButton(
        onPressed: () {
          setState(() {
            isTaped = !isTaped;
          });
        },
        backgroundColor: Color.fromRGBO(0, 102, 175, 1),
        child: Image.asset('assets/button_Images/Services.png') ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

//je change selon l'utilisateur
