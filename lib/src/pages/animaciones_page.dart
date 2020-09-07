import 'package:flutter/material.dart';
import 'dart:math' as Math;

//https://easings.net/en
class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    Key key,
  }) : super(key: key);

  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> moverDerecha;
  Animation<double> agrandar;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));

    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate( //Transform.rotate al widget principal y sus efectos
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    opacity = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(// Opacity() to widget principal
        parent: animationController,
        curve: Interval(0, 0.25, curve: Curves.easeOut)));

    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(//Transform.traslate al windget principal y sus animaciones
        parent: animationController,
        curve: Curves.easeOut));

    agrandar = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(//Transform.scale al widget principal // de cero hasta 2 veces su tamaño
        parent: animationController,
        curve: Curves.easeOut));

    animationController.addListener(() {
      print('Status: ${animationController.status}');
      if (animationController.status == AnimationStatus.completed) {
        // animationController.reverse();
        animationController.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Play / Reproduccion
    animationController.forward();

    return AnimatedBuilder(
        animation: animationController,
        child: _Rectangle(),
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
            offset: Offset(moverDerecha.value, 0),
            child: Transform.rotate(
                angle: rotation.value,
                child: Opacity(
                  opacity: opacity.value,
                  child: Transform.scale(scale: agrandar.value ,child: child),
                )),
          );
        });
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue),
      child: ListView(
        children: [],
      ),
    );
  }
}
