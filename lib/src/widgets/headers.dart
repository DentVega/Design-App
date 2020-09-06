import 'package:flutter/material.dart';

class HeaderCuadrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Color(0Xff615ABB),
    );
  }
}

class HeaderRedondeados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Color(0Xff615ABB),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(70))),
    );
  }
}
