import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGordo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _BotonGordoBackground(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140, width: 40,),
              FaIcon(FontAwesomeIcons.carCrash, color: Colors.white, size: 40,),
              SizedBox(width: 20,),
              Expanded(child: Text('Motor Accidente', style: TextStyle(color: Colors.white, fontSize: 18),)),
              FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white,),
              SizedBox(width: 40,),
            ],
          )
        ],
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                right: -20,
                top: -20,
                child: FaIcon(
                  FontAwesomeIcons.carCrash,
                  size: 150,
                  color: Colors.white.withOpacity(0.2),
                ))
          ],
        ),
      ),
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            Color(0xff6989F5),
            Color(0xff906EF5),
          ])),
    );
  }
}
