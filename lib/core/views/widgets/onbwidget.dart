import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class onbordWedgit extends StatefulWidget {
  @override
  State<onbordWedgit> createState() => _parcodState();
}

class _parcodState extends State<onbordWedgit> {
  @override
  Widget build(BuildContext context) {
    return onbordWedgit();
  }
}

Widget onbordpage({
  required String imagg,
  required String imggg,
}) {
  return Container(
    child: Stack(
      children: [
        Positioned(
          top: 20,
          right: 0,
          child: Center(
            child: Image.asset(
              imagg,
              fit: BoxFit.fill,
              height: 770,
              width: 400,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 5,
            child: Container(
              height: 260,
              width: 500,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        Positioned(
          bottom: 40,
          left: 10,
          child: Image.asset(
            imggg,
            fit: BoxFit.contain,
            height: 200,
            width: 370,
          ),
        ),
      ],
    ),
  );
}
