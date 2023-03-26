
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MiniZhouYiGuaWidget extends StatefulWidget {
  double height = 16;
  double width = 56;
  double guaInterval = 2;
  double yaoInterval = 4;
  late final String guaBinaryContent;
  late final String guaName;
  late final String guaExtraName;
  MiniZhouYiGuaWidget({Key? key,
    required this.guaBinaryContent,
    required this.guaName,
    required this.guaExtraName,
    this.height = 8,
    this.width = 64,
    this.yaoInterval = 4,
    this.guaInterval = 2}) : super(key: key);

  @override
  State<MiniZhouYiGuaWidget> createState() => _MiniZhouYiGuaWidgetState();
}

class _MiniZhouYiGuaWidgetState extends State<MiniZhouYiGuaWidget> {
  double get miniHeight => widget.height;
  double get miniWidth => widget.width;
  @override
  Widget build(BuildContext context) {
    List<int> guaBinaryIter = widget.guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    List<Widget> yaoWidgetList = guaBinaryIter.asMap().entries.map((entry) => miniZhouYiGuaYao(entry.value==1, entry.key)).toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed.toList();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      alignment: Alignment.center,
      height: miniHeight * 6 + widget.yaoInterval * 6 + widget.guaInterval + 40,
      // color: Colors.redAccent,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reversedYaoWidgetList[0],
            SizedBox(height:widget.yaoInterval),
            reversedYaoWidgetList[1],
            SizedBox(height:widget.yaoInterval),
            reversedYaoWidgetList[2],
            SizedBox(height:widget.yaoInterval + widget.guaInterval),
            reversedYaoWidgetList[3],
            SizedBox(height:widget.yaoInterval),
            reversedYaoWidgetList[4],
            SizedBox(height:widget.yaoInterval),
            reversedYaoWidgetList[5],
            SizedBox(height:widget.yaoInterval + widget.guaInterval),
            Column(
              children: [
                Container(
                    child: Text(
                      "${widget.guaName}",
                      style:TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    )
                ),
                widget.guaExtraName == null ?Container():Container(
                  child: Text(
                      "（${widget.guaExtraName}）",
                      style:TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      )),
                ),
              ],
            )
          ]
          /*children: [
            reversedYaoWidgetList[0],
            SizedBox(height:4),
            reversedYaoWidgetList[1],
            SizedBox(height:4),
            reversedYaoWidgetList[2],
            SizedBox(height:4 + widget.guaInterval),
            reversedYaoWidgetList[3],
            SizedBox(height:4),
            reversedYaoWidgetList[4],
            SizedBox(height:4),
            reversedYaoWidgetList[5],
            SizedBox(height:4),
            Column(
              children: [
                Container(
                    child: Text(
                      "${widget.guaName}",
                      style:TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                      "（${widget.guaExtraName}）",
                      style:TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                      )),
                ),
              ],
            )
          ]*/
      )
    );
  }
  Widget miniZhouYiGuaYao(bool yaoYinYang,int index){
    if (yaoYinYang){
      return Container(
        height: miniHeight,
        width: miniWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: yaoYinYang?Colors.white:Colors.black,
          color: Colors.black,
          borderRadius: BorderRadius.circular(64),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }else{
      return Container(
          height: miniHeight,
          width: miniWidth,
          child: buildYinYaoWidget(index)
      );
    }
  }
  Widget buildYinYaoWidget(int index){
    double eachSideWidth = miniWidth * 0.46;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: miniHeight,
            width: eachSideWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(64),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: miniWidth * 0.06,),
          Container(
            height: miniHeight,
            width: eachSideWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(64),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          )]
    );
  }

}
