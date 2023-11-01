
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Dev extends StatefulWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  State<Dev> createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            yang(256, 36),
            SizedBox(height: 12),
            yin(256,36),
            SizedBox(height: 12),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
                depth: 4,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Container(
                width: 256,
                height: 36,
              ),
            ),
            SizedBox(height: 12),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
                depth: 4,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Container(
                width: 256,
                height: 36,
              ),
            ),
            SizedBox(height: 12),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
                depth: 4,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Container(
                width: 256,
                height: 36,
              ),
            ),
            SizedBox(height: 12),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
                depth: 4,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Container(
                width: 256,
                height: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget yang(double width, double height){
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
        depth: 4,
        lightSource: LightSource.topLeft,
        color: Colors.white,
      ),
      child: Container(
        width: width,
        height: height,
      ),
    );
  }
  Widget yin(double width, double height){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
            depth: 4,
            lightSource: LightSource.topLeft,
            color: Colors.black87,
          ),
          child: Container(
            width: (width -  24) * 0.5,
            height: height,
          ),
        ),
        SizedBox(width: 24),
        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
            depth: 4,
            lightSource: LightSource.topLeft,
            color: Colors.black87,
          ),
          child: Container(
            width: (width -  24) * 0.5,
            height: height,
          ),
        ),

      ],
    );
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
        depth: 4,
        lightSource: LightSource.topLeft,
        color: Colors.white,
      ),
      child: Container(
        width: width,
        height: height,
      ),
    );
  }
}
