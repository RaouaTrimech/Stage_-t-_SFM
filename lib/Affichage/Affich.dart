import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../db/Consommation_Energy.dart';


class Affich extends StatefulWidget {
  const Affich({Key? key}) : super(key: key);

  @override
  State<Affich> createState() => _AffichState();
}

class _AffichState extends State<Affich> {
  bool Activate_Price = false ;


  int index = 0 ;
  int chartMode = 0;

  late List<EnergyConsumptionData> _chartData ;
  late TooltipBehavior _tooltipBehavior;

  //fictionnary number to try
  int nombreEtages = 10;


  initState(){
    _chartData = getchartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  //Fake data for the chart to work on
  List<EnergyConsumptionData> getchartData(){
    final List<EnergyConsumptionData> chartData = [
      EnergyConsumptionData(DateTime.now(),20,10),
      EnergyConsumptionData(DateTime(DateTime.now().hour+1),20,10),
      EnergyConsumptionData(DateTime(DateTime.now().hour+2),12,5),
      EnergyConsumptionData(DateTime(DateTime.now().hour+3),16,12),
      EnergyConsumptionData(DateTime(DateTime.now().hour+4),18,13),
      EnergyConsumptionData(DateTime(DateTime.now().hour+5),16,19),
      EnergyConsumptionData(DateTime(DateTime.now().hour+6),17,3),
    ];
    return chartData;
  }


  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(Icons.home_rounded ,size: 30 ,color: Color.fromRGBO(0, 102, 175, 1)),
      Icon(Icons.library_books_outlined,size: 30,color: Color.fromRGBO(0, 102, 175, 1) ),
      Icon(Icons.bar_chart_rounded,size: 30,color: Color.fromRGBO(0, 102, 175, 1)),
      Icon(Icons.settings,size: 30 ,color: Color.fromRGBO(0, 102, 175, 1)),
    ];


    return Scaffold(
      extendBody : true ,
      body:
      //top of the page
      Column(
        children: [
          //header
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Return button
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                      Icons.arrow_left_outlined),
                  color: Color.fromRGBO(0, 102, 175, 1),
                ),
                //Title
                buildTitle(index),
                //Switch button
                buildEntete(index),
              ],
            ),
          ),
          /* //to add space until the end
          /*Spacer(),*/*/
          /* Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
            ],
          ),*/
          //----------------Body-------------//
          SizedBox(height: 15,),
          //the chart
          buildBody(index),

        ],
      ) ,

      bottomNavigationBar:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CurvedNavigationBar(
            color: Color.fromRGBO(193, 196, 198, .76),
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
            items: items,
            height: 60,
            index: index,
            onTap: (index) => setState(()=> this.index = index),
          ),
          Container(
            height: 15,
            color: Color.fromRGBO(0, 102, 175, 1),
          ),
          Container(
            height: 15,
            color: Color.fromRGBO(247, 131, 27, 0.73),
          ),
        ],
      ),
    );
  }


  Widget buildSpecialSwitch() => Transform.scale(
    scale: 1.3,
    child: Switch(
      activeThumbImage: AssetImage('assets/button_Images/money.png'),
      inactiveThumbImage: AssetImage('assets/button_Images/energy.png'),
      value: Activate_Price,
      activeColor: Color.fromRGBO(0, 102, 175, 1),
      inactiveThumbColor: Color.fromRGBO(247, 131, 27, 0.73),
      onChanged: (value) => setState(()=> this.Activate_Price = value),
    ),
  );

  Widget buildEntete(int index){
    if(index ==1 || index ==2 ){
      return buildSpecialSwitch();
      //Live on
    }

    return Container();
  }
  Widget buildBody(int index ){
    //home
    if(index ==0){
      return Text('Home Page');
      //Live on
    }
    else if (index ==1 ){
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 300,
                width: 380,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:Border.all(color: Color.fromRGBO(105, 103, 103, 1),),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ]
                ),
                child: SfCartesianChart(
                  legend: Legend(isVisible: true , position: LegendPosition.bottom),
                  tooltipBehavior: _tooltipBehavior,
                  //backgroundColor: Colors.white,
                  series: (Activate_Price) ?
                  <ChartSeries>[
                    //energy chart
                    StackedLineSeries<EnergyConsumptionData,String?>(
                      dataSource: _chartData,
                      xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                      yValueMapper:(EnergyConsumptionData exp, _)=> exp.consumption,
                      name: 'consommation Energie',
                    ),
                    //money chart
                    StackedLineSeries<EnergyConsumptionData,String?>(
                      dataSource: _chartData,
                      xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                      yValueMapper:(EnergyConsumptionData exp, _)=> exp.price,
                      name: 'prix',
                      color: Color.fromRGBO(247, 131, 27, 1),
                    ),
                  ]
                      : <ChartSeries>[
                    //energy chart
                    StackedLineSeries<EnergyConsumptionData,String?>(
                      dataSource: _chartData,
                      xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                      yValueMapper:(EnergyConsumptionData exp, _)=> exp.consumption,
                      name: 'consommation Energie',
                    ),
                  ],
                  primaryXAxis: CategoryAxis(),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Liste des Appareils allumés',
                style: TextStyle(
                  color: Color.fromRGBO(247, 131, 27, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  fontFamily: 'Prata',
                ),
              ),
            ),
          ],
        ),

      );
      //Summary
    }
    else if (index ==2){
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*BottomBarLine(
                currentIndex: chartMode,
                onTap: (int ind) {
                  if (ind != chartMode) {
                    setState(() {
                      chartMode = ind;
                    });
                  }
                }
              ),*/
              Center(
                child: Container(
                  height: 50,
                  width: 380,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Color.fromRGBO(105, 103, 103, 1),),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Today
                      GestureDetector(
                        onTap: () {
                          setState((){
                            chartMode =0;
                          });
                        },
                        child: Text('Today',
                          style: TextStyle(
                            color:(chartMode == 0) ? Color.fromRGBO(0, 102, 175, 1) :Color.fromRGBO(105, 103, 103, 1) ,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                      SizedBox(width: 10,),
                      //Week
                      GestureDetector(
                        onTap: () {
                          setState((){
                            chartMode =1;
                          });
                        },
                        child: Text('Week',
                          style: TextStyle(
                            color: (chartMode == 1) ? Color.fromRGBO(0, 102, 175, 1) :Color.fromRGBO(105, 103, 103, 1) ,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                      SizedBox(width: 10,),
                      //Monthly
                      GestureDetector(
                        onTap: () {
                          setState((){
                            chartMode =2;
                          });
                        },
                        child: Text('Monthly',
                          style: TextStyle(
                            color: (chartMode == 2) ? Color.fromRGBO(0, 102, 175, 1) :Color.fromRGBO(105, 103, 103, 1) ,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Container(
                  height: 300,
                  width: 380,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Color.fromRGBO(105, 103, 103, 1),),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ]
                  ),
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true , position: LegendPosition.bottom),
                    tooltipBehavior: _tooltipBehavior,
                    //backgroundColor: Colors.white,
                    series: (Activate_Price) ?
                    <ChartSeries>[
                      //energy chart
                      StackedColumnSeries<EnergyConsumptionData,String?>(
                        dataSource: _chartData,
                        xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                        yValueMapper:(EnergyConsumptionData exp, _)=> exp.consumption,
                        name: 'consommation Energie',
                      ),
                      //money chart
                      StackedColumnSeries<EnergyConsumptionData,String?>(
                        dataSource: _chartData,
                        xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                        yValueMapper:(EnergyConsumptionData exp, _)=> exp.price,
                        name: 'prix',
                        color: Color.fromRGBO(247, 131, 27, 1),
                      ),
                    ]
                        : <ChartSeries>[
                      //energy chart
                      StackedColumnSeries<EnergyConsumptionData,String?>(
                        dataSource: _chartData,
                        xValueMapper: (EnergyConsumptionData exp, _)=> "${exp.dateM}", /*DateFormat.Hms().format(exp.dateM)*/
                        yValueMapper:(EnergyConsumptionData exp, _)=> exp.consumption,
                        name: 'consommation Energie',
                      ),
                    ],
                    primaryXAxis: CategoryAxis(),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Espace & Equipements',
                  style: TextStyle(
                    color: Color.fromRGBO(247, 131, 27, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                    fontFamily: 'Prata',
                  ),
                ),
              ),
              ListeEtages(nombreEtages),
              //to add some space at the buttom
              Container(
                height: 80,
              )
            ],
          ),

        ),
      );
      //Configuration
    }else if (index == 3){
      return Text('Config');
    }

    return Container();
  }

  Widget buildTitle(int index ){
    //home
    if(index ==0){
      return Text(
        'Home',
        style: TextStyle(
          color: Color.fromRGBO(0, 102, 175, 1),
          fontWeight: FontWeight.normal,
          fontSize: 30,
          fontFamily: 'Prata',
        ),
      );
      //Live on
    }
    else if (index ==1 ){
      return Text(
        'Live Now',
        style: TextStyle(
          color: Color.fromRGBO(0, 102, 175, 1),
          fontWeight: FontWeight.normal,
          fontSize: 30,
          fontFamily: 'Prata',
        ),
      );
      //Summary
    }
    else if (index ==2){
      return Text(
        'Summary',
        style: TextStyle(
          color: Color.fromRGBO(0, 102, 175, 1),
          fontWeight: FontWeight.normal,
          fontSize: 30,
          fontFamily: 'Prata',
        ),
      );
      //Configuration
    }
    else if (index == 3){
      return Text(
        'Configurations',
        style: TextStyle(
          color: Color.fromRGBO(0, 102, 175, 1),
          fontWeight: FontWeight.normal,
          fontSize: 30,
          fontFamily: 'Prata',
        ),
      );
    }

    return Container();
  }

  Widget ListeEtages(int n) {
    List<Widget> EtageButton = [];
    for(int i = 1 ;i<= n; i+=2 ){
      EtageButton.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButtonEtage(i),
                SizedBox(width: 5,),
                buildButtonEtage(i+1),

              ],
            ),
          )
      );
    }
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: EtageButton,
    );
  }

  Widget buildButtonEtage(int i){
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 100,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:Border.all(color: Color.fromRGBO(105, 103, 103, 1),),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]
      ),
      child: ElevatedButton(
        onPressed: (){
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ()),
          );*/
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.apartment_rounded,
              color: Color.fromRGBO(0, 102, 175, 1),
              size: 45,
            ),
            SizedBox(width: 5,),
            Text(
              '$i Etage',
              style: TextStyle(
                color:Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: 'Roboto',
              ),
            )
          ],
        ),
        style:  ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}
