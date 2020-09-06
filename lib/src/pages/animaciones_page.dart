import 'package:flutter/material.dart';
import 'dart:math' as Math;

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

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(animationController);

    animationController.addListener(() {
      print('Status: ${animationController.status}');
      if(animationController.status == AnimationStatus.completed) {
        animationController.reverse();
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
        // child: _Rectangle(),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(angle: rotation.value, child: _Rectangle());
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
    );
  }
}
