// import 'package:design_app/src/pages/animaciones_page.dart';
// import 'package:design_app/src/labs/circular_progress_page.dart';
// import 'package:design_app/src/pages/graficas_circulares.dart';
// import 'package:design_app/src/labs/slideshow_page.dart';
import 'package:design_app/src/pages/emergency_page.dart';
// import 'package:design_app/src/pages/pinterest_page.dart';
// import 'package:design_app/src/pages/slideshow_page.dart';
// import 'package:design_app/src/retos/cuadrado_animado_page.dart';
// import 'package:design_app/src/pages/headers_page.dart';
import 'package:flutter/material.dart';
//flutter run -d all
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: EmergencyPage(),
    );
  }
}
