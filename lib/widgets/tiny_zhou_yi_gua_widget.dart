
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class TinyZhouYiGuaWidget extends StatefulWidget {
  double height = 16;
  double width = 56;
  double guaInterval = 2;
  double yaoInterval = 4;
  bool displayYinYang = false;
  late final String guaBinaryContent;
  late final String guaName;
  late final String? guaExtraName;
  late List<int> changedYaoIndexList=[];
  TinyZhouYiGuaWidget({Key? key,
    required this.guaBinaryContent,
    required this.guaName,
    required this.guaExtraName,
    required this.height,
    required this.width,
    this.yaoInterval = 4,
    this.guaInterval = 1,
    this.displayYinYang = false,
  this.changedYaoIndexList = const []}) : super(key: key);

  @override
  State<TinyZhouYiGuaWidget> createState() => _TinyZhouYiGuaWidgetState();
}

class _TinyZhouYiGuaWidgetState extends State<TinyZhouYiGuaWidget> {
  double get tinyHeight => widget.height;
  double get tinyWidth => widget.width;
  @override
  Widget build(BuildContext context) {
    List<int> guaBinaryIter = widget.guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    List<Widget> yaoWidgetList = guaBinaryIter.asMap().entries.map((entry) => tinyZhouYiGuaYao(entry.value==1, entry.key,widget.changedYaoIndexList.contains(entry.key))).toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed.toList();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
      alignment: Alignment.center,
      height: tinyHeight * 6 + widget.yaoInterval * 5 + widget.guaInterval + 36 + 8,
      // padding: EdgeInsets.only(top: 4),
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
            widget.guaName == ""?Container():SizedBox(height:widget.yaoInterval + widget.guaInterval *4),
            widget.guaName == ""?Container():Column(
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
                        fontSize: 10,
                        color: Colors.black54,
                      )),
                ),
              ],
            )
          ])
    );
  }
  Widget tinyZhouYiGuaYao(bool yaoYinYang,int index, bool isChangedYao){
    if (yaoYinYang){
      return Container(
        height: tinyHeight,
        width: tinyWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: yaoYinYang?Colors.white:Colors.black,
          color: widget.displayYinYang?(yaoYinYang?Colors.white:Colors.black):(isChangedYao?Colors.redAccent:Colors.black),
          borderRadius: BorderRadius.circular(64),
          boxShadow: [
            BoxShadow(
              color: isChangedYao?Colors.redAccent.withOpacity(0.3):Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }else{
      return Container(
          height: tinyHeight,
          width: tinyWidth,
          child: buildYinYaoWidget(index,isChangedYao)
      );
    }
  }
  Widget buildYinYaoWidget(int index,bool isChangedYao){
    double eachSideWidth = tinyWidth * 0.46;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: tinyHeight,
            width: eachSideWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isChangedYao?Colors.red:Colors.black,
              borderRadius: BorderRadius.circular(64),
              boxShadow: [
                BoxShadow(
                  color: isChangedYao?Colors.red:Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: tinyWidth * 0.06,),
          Container(
            height: tinyHeight,
            width: eachSideWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isChangedYao?Colors.red:Colors.black,
              borderRadius: BorderRadius.circular(64),
              boxShadow: [
                BoxShadow(
                  color: isChangedYao?Colors.red:Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          )]
    );
  }

}
