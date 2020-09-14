import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  final bool gradient;
  final bool viewText;

  RadialProgress(
      {@required this.porcentaje,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.grosorPrimario = 10,
      this.grosorSecundario = 4,
      this.gradient = false,
      this.viewText = false});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return Stack(
      children: [
        widget.viewText
            ? Container(
                width: 170,
                height: 170,
                child: Center(
                  child: Text(
                    '${widget.porcentaje} %',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : Container(),
        AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Container(
                padding: EdgeInsets.all(10),
                width: 170,
                height: 170,
                child: CustomPaint(
                  painter: _MiRadialProgress(
                      (widget.porcentaje - diferenciaAnimar) +
                          (diferenciaAnimar * animationController.value),
                      widget.colorPrimario,
                      widget.colorSecundario,
                      widget.grosorPrimario,
                      widget.grosorSecundario,
                      gradient: widget.gradient),
                ),
              );
            }),
      ],
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  final bool gradient;

  _MiRadialProgress(this.porcentaje, this.colorPrimario, this.colorSecundario,
      this.grosorPrimario, this.grosorSecundario,
      {this.gradient = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradiente = new LinearGradient(
        colors: <Color>[Color(0xffC012FF), Color(0xff6D05E8), Colors.red]);

    final Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: 180);

    final paint = new Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radio = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco = new Paint()
      ..strokeWidth = grosorPrimario
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (gradient) {
      paintArco.shader = gradiente.createShader(rect);
    } else {
      paintArco.color = colorPrimario;
    }

    //Parte que se debera ir llenando
    double arcAngulo = 2 * pi * (porcentaje / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -pi / 2,
        arcAngulo, false, paintArco);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
