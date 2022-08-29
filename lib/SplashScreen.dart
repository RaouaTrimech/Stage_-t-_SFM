import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'Forms/Fiche_Site.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset(
                'assets/Voltix_logo.png',
                height: 100,
                width: 100,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Voltix',
                  style: TextStyle(
                    color: Color.fromRGBO(88, 89, 91, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 45,
                    fontFamily: 'Prata',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
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

          ],
        ),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 350,
        duration:5,
        nextScreen: FicheSite());
  }
}
