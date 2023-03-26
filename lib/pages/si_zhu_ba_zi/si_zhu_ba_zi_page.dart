
import 'package:flutter/material.dart';

class SiZhuBaZiPage extends StatefulWidget {
  const SiZhuBaZiPage({Key? key}) : super(key: key);

  @override
  State<SiZhuBaZiPage> createState() => _SiZhuBaZiPageState();
}

class _SiZhuBaZiPageState extends State<SiZhuBaZiPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var size = (screenWidth <= screenHeight ? screenWidth : screenHeight) - 16;
    var eachCellWidth = size / 0.125;
    return Scaffold(
      body: Center(
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 64),
              siZhuBaZi(eachCellWidth),
            ],
          ),

        ),
      ),
    );
  }
  Widget siZhuBaZi(double eachWidth){
    return Table(
        columnWidths: {
          0: FlexColumnWidth(eachWidth),
          1: FlexColumnWidth(eachWidth),
          2: FlexColumnWidth(eachWidth),
          3: FlexColumnWidth(eachWidth),
          4: FlexColumnWidth(eachWidth),
          5: FlexColumnWidth(eachWidth),
        },
      children: [
        TableRow(
          children:[
            // TableCell(child: Container(height: 32, color: Colors.white,)),
            // TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),
            // TableCell(child: Container(height: 32, color: Colors.white,)),
            // TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),
            // TableCell(child: Container(height: 32, color: Colors.white,)),
            // TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),

            // ["","枭神","劫财","日主","劫财",""],
            TableCell(child: Container(height: 32, color: Colors.white,)),
            TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),
            TableCell(child: Container(height: 32, color: Colors.white,)),
            TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),
            TableCell(child: Container(height: 32, color: Colors.white,)),
            TableCell(child: Container(height: 32, color: Colors.lightBlueAccent.withOpacity(0.4))),
          ]
        )
      ],
    );
  }
}
