
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class SmallZhouYiGuaWidget extends StatefulWidget {
  double height = 16;
  double width = 56;
  late final String guaBinaryContent;
  late final String guaName;
  late final String guaExtraName;
  SmallZhouYiGuaWidget({Key? key,required this.guaBinaryContent,required this.guaName,required this.guaExtraName,required this.height,required this.width}) : super(key: key);

  @override
  State<SmallZhouYiGuaWidget> createState() => _SmallZhouYiGuaWidgetState();
}

class _SmallZhouYiGuaWidgetState extends State<SmallZhouYiGuaWidget> {
  double get smallHeight => widget.height;
  double get smallWidth => widget.width;
  @override
  Widget build(BuildContext context) {
    List<int> guaBinaryIter = widget.guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    List<Widget> yaoWidgetList = guaBinaryIter.asMap().entries.map((entry) => smallZhouYiGuaYao(entry.value==1, entry.key)).toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      alignment: Alignment.center,
      height: 12 * 6 + 6 * 6 + 36,
      // color: Colors.redAccent,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reversedYaoWidgetList.toList()..add(Column(
            children: [Container(
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
          ))),
    );
  }
  Widget smallZhouYiGuaYao(bool yaoYinYang,int index){
    if (yaoYinYang){
      return Container(
        height: smallHeight,
        width: smallWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: yaoYinYang?Colors.white:Colors.black,
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
          height: smallHeight,
          width: smallWidth,
          child: buildYinYaoWidget(index)
      );
    }
  }
  Widget buildYinYaoWidget(int index){
    Curve curve = Curves.easeOutBack; // Curves.easeInOutBack;
    double eachSideWidth = smallWidth * 0.46;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: smallHeight,
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
          SizedBox(width: smallWidth * 0.06,),
          Container(
            height: smallHeight,
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
