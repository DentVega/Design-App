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

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    opacity = Tween(begin: 0.1, end: 1.0).animate(animationController);

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
          return Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value,
                child: child,
              ));
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
