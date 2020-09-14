import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Color colorBlanco = Colors.white.withOpacity(0.7);

    return Stack(
      children: [
        _IconHeaderBackground(),
        Positioned(
            top: -50,
            left: -70,
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 250,
              color: Colors.white.withOpacity(0.2),
            )),
        Column(
          children: [
            SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Text('Haz solicitado', style: TextStyle(fontSize: 20, color: colorBlanco),),
            SizedBox(
              height: 20,
            ),
            Text('Asistencia Medica', style: TextStyle(fontSize: 25, color: colorBlanco, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            FaIcon(
              FontAwesomeIcons.plus,
              size: 80,
              color: Colors.white,
            )
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff526BF6),
                Color(0xff67ACF2),
              ])),
    );
  }
}
