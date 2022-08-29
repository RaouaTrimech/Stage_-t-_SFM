import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_range/flutter_time_range.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Model/horaire_occup_database.dart';
import '../db/Site_db.dart';


class Horaires_Occup extends StatefulWidget {
  Widget wid ;
  int id_SSE;
  Horaires_Occup({Key? key , required this.wid , required this.id_SSE}) : super(key: key);

  @override
  State<Horaires_Occup> createState() => _Horaires_OccupState();
}

class _Horaires_OccupState extends State<Horaires_Occup> {

  List<HoraireOccup> Horaires_Occupa = [];
  late int _id_SSE;
  late bool isCliked  ;

  void initState() {
    super.initState();
    _id_SSE = widget.id_SSE;

    buildOccupHoursList();
  }

  //*** Day choice ***//
  //int number_lines = 1;

  List<DayInWeek> _days = [
    //Dimanche
    DayInWeek(
      "Sun",
    ),
    //Lundi
    DayInWeek(
      "Mon",
    ),
    //Mardi
    DayInWeek(
        "Tue",
        isSelected: true
    ),
    //Mercredi
    DayInWeek(
      "Wed",
    ),
    //Jeudi
    DayInWeek(
      "Thu",
    ),
    //Vendredi
    DayInWeek(
      "Fri",
    ),
    //Samedi
    DayInWeek(
      "Sat",
    ),
  ];



  List<Widget> Day_Hour = [];

  Widget buildOccupLine(int n){

    var Hour_day = HoraireOccup(days: [], debutHour: DateTime.now(), finHour: DateTime.now(), id_ssEspace: 0);
    Horaires_Occupa.add(Hour_day);
    return Column(
      children: [
        ///Days Selection
        Text(
          "Choisir les jours de la semaine:",
          style: TextStyle(
            color: Color.fromRGBO(88, 89, 91, 1),
            fontWeight: FontWeight.normal,
            fontSize: 12,
            fontFamily: 'Prata',
          ),
        ),
        ///creating an instance for days (setting the days)
        SelectWeekDays(
            selectedDayTextColor: Color.fromRGBO(0, 102, 175, 1),
            onSelect: (values){
              Hour_day.days = values;
              Horaires_Occupa.elementAt(n).days = values;
            },
            days: _days
        ),
        //-----------------------------------------//
        ///Hour selection
        Text(
          "Choisir les horaires:",
          style: TextStyle(
            color: Color.fromRGBO(88, 89, 91, 1),
            fontWeight: FontWeight.normal,
            fontSize: 12,
            fontFamily: 'Prata',
          ),
        ),

        TimeRangePicker(
          initialFromHour: DateTime.now().hour,
          initialFromMinutes: DateTime.now().minute,
          initialToHour: DateTime.now().hour,
          initialToMinutes: DateTime.now().minute,
          backText: "Back",
          nextText: "Next",
          cancelText: " ",
          selectText: "Sauvegarder",
          editable: true,
          is24Format: true,
          disableTabInteraction: true,
          iconNext: Icon(Icons.arrow_forward, size: 12),
          iconBack: Icon(Icons.arrow_back, size: 12),
          iconSelect: Icon(Icons.check, size: 12),
          separatorStyle: TextStyle(color: Colors.grey[900], fontSize: 30),
          onSelect: (from, to) {
            ///récuperer les données
            setState((){
              Hour_day.debutHour = DateTime(Hour_day.debutHour.year, Hour_day.debutHour.month, Hour_day.debutHour.day, from.hour, from.minute, Hour_day.debutHour.second, Hour_day.debutHour.millisecond, Hour_day.debutHour.microsecond);
              Hour_day.finHour = DateTime(Hour_day.finHour.year, Hour_day.finHour.month, Hour_day.finHour.day, to.hour, to.minute, Hour_day.finHour.second, Hour_day.finHour.millisecond, Hour_day.finHour.microsecond);
              Horaires_Occupa.elementAt(n).debutHour = Hour_day.debutHour ;
              Horaires_Occupa.elementAt(n).finHour = Hour_day.finHour ;
            });
            ///sauvegarder message
            Fluttertoast.showToast(
              msg: "l'horaire est sauvegardé",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
            );

          },
          onCancel: () {},
        ),
        //-----------------------------------------
      ],
    );
  }

  void buildOccupHoursList(){
    Day_Hour.add(
      buildOccupLine(0),
    );

  }

  Future buildOccupHours(){

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (context,setState){
                return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color.fromRGBO(193, 196, 198, .76), width: 4)
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///Header topper
                            Column(
                              children: [
                                Container(
                                  height: 10,
                                  color: Color.fromRGBO(193, 196, 198, .76),
                                ),
                                Container(
                                  height: 10,
                                  color: Color.fromRGBO(0, 102, 175, 1),
                                ),
                                Container(
                                  height: 10,
                                  color: Color.fromRGBO(247, 131, 27, 0.73),
                                )
                              ],
                            ),
                            ///Header Title
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Horaires d'occupation",
                                style: TextStyle(
                                  color: Color.fromRGBO(88, 89, 91, 1),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 25,
                                  fontFamily: 'Prata',
                                ),
                              ),
                            ),
                            ///Body
                            SizedBox(
                              height: 500,
                              child:ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: Day_Hour.length,
                                itemBuilder:(context ,index) {
                                  return Card(
                                    child: ListTile(
                                      title:
                                      (index == 0)?
                                      ///day_time widget
                                      Day_Hour.elementAt(index)
                                          :
                                      Column(
                                        children: [
                                          ///delete button
                                          IconButton(
                                            onPressed: (){
                                              setState(() {
                                                Horaires_Occupa.removeAt(index);
                                                Day_Hour.removeAt(index);
                                              });
                                            },
                                            icon:Icon(
                                              Icons.cancel_presentation,
                                              size: 20,
                                              color: Color.fromRGBO(247, 131, 27, 0.73),
                                            ),
                                          ),
                                          ///day_time widget
                                          Day_Hour.elementAt(index),
                                        ],
                                      ),
                                    ),
                                  );
                                },

                                //children: Day_Hour,
                              ) ,
                            ),
                            ///add another schedule button
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 30,
                              width: 245,
                              child: ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    Day_Hour.add(buildOccupLine(Day_Hour.length -1),);
                                  });
                                },
                                child: Text("Ajouter un autre horaire"),
                                style:  ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(40, 172, 45, 1),),
                                ),
                              ),
                            ),
                            ///Save Button
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 40,
                              width: 220,
                              child: ElevatedButton(
                                onPressed: (){
                                  for(int i = 0 ; i < Horaires_Occupa.length ; i ++){
                                    Horaires_Occupa.elementAt(i).id_ssEspace = _id_SSE;
                                    SiteDB.instance.createHourOccup(Horaires_Occupa.elementAt(i));
                                  }
                                  Navigator.pop(context);

                                },
                                child: Text("Sauvegarder"),
                                style:  ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 102, 175, 1),),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                );
              }
          );
        }
    );
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buildOccupHours(),
      child: widget.wid,
    );
  }
}
