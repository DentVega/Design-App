import 'package:design_app/src/widgets/boton_gordo.dart';
import 'package:design_app/src/widgets/icon_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BotonGordo(),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: FontAwesomeIcons.plus,
      titulo: 'Asistencia Medica',
      subTitulo: 'Haz solicitado',
      color1: Color(0xff526BF6),
      color2: Color(0xff67ACF2),
    );
  }
}
