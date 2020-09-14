import 'package:flutter/material.dart';

class BotonGordo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _BotonGordoBackground(),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.red, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 6),
            blurRadius: 10)
      ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [
          Color(0xff6989F5),
          Color(0xff906EF5),
        ])
      ),
    );
  }
}
