import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'Forms/Infos_Equipements_ZM.dart';


class ScanPage extends StatefulWidget {
  //String Param ;
  ScanPage({Key? key /*, required this.Param*/}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  //we need the qrKey to access the information collected from the QRView
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  //String? _param ;

  @override
  void initState(){
    super.initState();
    //_param = widget.Param;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //to garanty that the hot reload is working
  @override
  void reassemble() async {
    super.reassemble();

    //to fiw the hot reload on the camera
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom:20 ,child: buildResult()),
          Positioned(top:20 ,child: buildControlButtons()),
        ],
      ),
    );
  }

  Widget buildControlButtons() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {});
          },
          icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context , snapshot){
                if(snapshot.data != null){
                  return Icon(
                      snapshot.data! ?Icons.flash_on_outlined : Icons.flash_off_outlined);
                }else{
                  return Container();
                }
              }
          ),
        ),
        IconButton(
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {});
          },
          icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context , snapshot){
                if(snapshot.data != null){
                  return Icon(Icons.flip_camera_android_outlined);
                }else{
                  return Container();
                }
              }
          ),
        ),
      ],
    ),
  );

  Widget buildResult() =>
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}':'Scan  a code!',
          maxLines: 3,
        ),
      );


  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width * 0.8 ,
      borderWidth: 20,
      borderLength: 20,
      borderColor: Color.fromRGBO(193, 196, 198, .76),
    ),
  );

  //the controller is used to control the scanning area
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen(
            (barcode) {
          setState(() => this.barcode = barcode);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoEquipement_ZM(ScannedID: barcode.toString()/*, PrincipUsages: _param!,*/)),
          );
        }

    );


  }
}

