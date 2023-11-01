
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';

class ZhouYiGuaWidget extends StatefulWidget {
  Duration duration = const Duration(milliseconds: 300);
  late final String guaBinaryContent;
  late final String? fullGuaName;
  late ValueNotifier<int> selectedYaoNotifier ;
  ZhouYiGuaWidget({Key? key,required this.guaBinaryContent,this.fullGuaName, ValueNotifier<int>? selectedIndexNotifier}) : super(key: key){
    if (selectedIndexNotifier == null) {
      selectedYaoNotifier = ValueNotifier(-1);
    } else {
      selectedYaoNotifier = selectedIndexNotifier;
    }
  }

  @override
  State<ZhouYiGuaWidget> createState() => _ZhouYiGuaWidgetState();
}

class _ZhouYiGuaWidgetState extends State<ZhouYiGuaWidget> with SingleTickerProviderStateMixin{

  late AnimationController _scaleAnimationController;
  DateTime? _lastScaleAt;
  /*late Animation<double> scale;*/

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
    vsync: this,
    duration: widget.duration,
    );
    /*scale = Tween(begin: 1.0, end: 1.6).animate(_scaleAnimationController);*/
  }
  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> guaBinaryIter = widget.guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    List<Widget> yaoWidgetList = guaBinaryIter.asMap().entries.map((entry) => zhouYiYao(entry.value==1, entry.key)).toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed;
    return AnimatedContainer(
      margin: const EdgeInsets.all(16),
      alignment: Alignment.center,
      // height: 24 * 6 + 10 * 5 + 12 * 2 + 36,
      height: 24 * 6 + 10 * 5 + (widget.fullGuaName == null ? 0 : 12),
      // color: Colors.redAccent,
      duration: Duration(milliseconds: 300),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reversedYaoWidgetList.toList()..add(Column(
            children: [
              widget.fullGuaName == null ? Container():Container(
              child: Text(
                widget.fullGuaName!,
                style:TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ).animate(onPlay:((ctl) => ctl.repeat(reverse: false)))
                  .shimmer(
                duration: 2000.ms,),
            ),
            ],
          ))),
    );
  }
  Widget build_scalable(BuildContext context) {

    List<int> guaBinaryIter = widget.guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    List<Widget> yaoWidgetList = guaBinaryIter.asMap().entries.map((entry) => zhouYiYao(entry.value==1, entry.key)).toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed;
    return GestureDetector(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(16),
        alignment: Alignment.center,
        height: 24 * 6 + 10 * 5 + 12 * 2 + 36,
        // color: Colors.redAccent,
        duration: Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reversedYaoWidgetList.toList()..add(Column(
            children: [widget.fullGuaName == null ? Container():Container(
            child: Text(
              widget.fullGuaName!,
              style:TextStyle(
                fontSize: 18,
                color: Colors.black54,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ).animate(onPlay:((ctl) => ctl.repeat(reverse: false)))
                .shimmer(
              duration: 2000.ms,),
          ),Container(
          margin: EdgeInsets.only(top: 2),
          child: Text(
              "（本）",
              style:TextStyle(
                fontSize: 18,
                color: Colors.black38,
              )),
        ),
        ],
          ))),
      )
          .animate(controller: _scaleAnimationController,onPlay: ((ctl) => {
      if (ctl.status == AnimationStatus.forward && _lastScaleAt == null){
          // showToast("first play");
          ctl.reset()
      }
    }))
          .scale(alignment: Alignment.center,begin: Offset(1,1),end: Offset(1.6,1.6),duration: widget.duration,curve: Curves.fastOutSlowIn),
      onTap: (){
        showToast("scaling");
        _lastScaleAt = DateTime.now();
        _scaleAnimationController.forward();
      },
    );
  }
  bool isScaled = false;
  int selectedIndex = -1;


  Widget zhouYiYao(bool yaoYinYang,int index){
    if (yaoYinYang){
      return GestureDetector(
          onDoubleTap: (){
            showToast("scaling...");
            if (isScaled){
              _scaleAnimationController.reverse();
              isScaled = false;
              return;
            }else{
              _scaleAnimationController.forward();
              isScaled = true;
            }
          },
          onTap: (){
            if (widget.selectedYaoNotifier.value == index){
              widget.selectedYaoNotifier.value = -1;
            } else {
              widget.selectedYaoNotifier.value = index;
            }
            // print("single tap $index");
            // if (selectedIndex == index){
            //   selectedIndex = -1;
            //   widget.selectedYaoNotifier.value = -1;
            // } else {
            //   selectedIndex = index;
            //
            //   widget.selectedYaoNotifier.value = index;
            // }
            // setState(() {
            // });
          },
          child: ValueListenableBuilder(
              valueListenable: widget.selectedYaoNotifier,
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: widget.duration,
                  height: value == index ? 28 :24,
                  width: value == index ? 168 :140,
                  // height: selectedIndex == index ? 42 :36,
                  // width: selectedIndex == index ? 180 :168,
                  alignment: Alignment.center,
                  curve: Curves.easeOutBack,
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
                  child: value == index
                      ? AnimatedContainer(
                    duration: widget.duration,
                    curve: Curves.easeOutBack,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(64),
                    ),
                    height: value == index ? 28 :24,
                    width: value == index ? 168 :140,
                    // height: selectedIndex == index ? 42 :36,
                    // width: selectedIndex == index ? 180 :168,
                    alignment: Alignment.center,
                  ).animate(onPlay:((ctl){
                    if (value == index) {
                      ctl.repeat(reverse: false);
                    }
                  })).shimmer(
                    // size: 0.3,
                    color: value!=index?Colors.transparent:Colors.black38.withOpacity(.2),
                    duration: 3000.ms,)
                      :Container(),
                );
              }
          )
      );
    }else{
      return GestureDetector(
          onDoubleTap: (){
            showToast("scaling...");
            if (isScaled){
              _scaleAnimationController.reverse();
              isScaled = false;
              return;
            }else{
              _scaleAnimationController.forward();
              isScaled = true;
            }
          },
          onTap: (){
            if (widget.selectedYaoNotifier.value == index){
              widget.selectedYaoNotifier.value = -1;
            } else {
              widget.selectedYaoNotifier.value = index;
            }
            // print("single tap $index");
            // if (selectedIndex == index){
            //   selectedIndex = -1;
            //   widget.selectedYaoNotifier.value = -1;
            // } else {
            //   selectedIndex = index;
            //   widget.selectedYaoNotifier.value = index;
            // }
            // setState(() {
            // });
          },
          child:ValueListenableBuilder(
            valueListenable: widget.selectedYaoNotifier,
            builder: (context, value, child) {
              return AnimatedContainer(
                  duration: widget.duration,
                  height: value == index ? 28 :24,
                  width: value == index ? 168 :140,
                  // height: selectedIndex == index ? 42 :36,
                  // width: selectedIndex == index ? 180 :168,
                  alignment: Alignment.center,
                  curve: Curves.easeOutBack,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: value == index ? 28 :24,
                          width: (value == index ? 168 :140) * 0.46,
                          curve: Curves.easeOutBack,
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
                        SizedBox(width: (value == index ? 168 :140) * 0.06,),
                        // SizedBox(width: (selectedIndex == index ? 180 :168) * 0.06,),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: value == index ? 28 :24,
                          width: (value == index ? 168 :140) * 0.46,
                          curve: Curves.easeOutBack,
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
                  ).animate(onPlay:((ctl){
                    if (value == index) {
                      ctl.repeat(reverse: false);
                    }
                  })).shimmer(
                    color: value!=index?Colors.transparent:Colors.white54,
                    duration: 3000.ms,)
              );
            },
          )
      );
    }
  }

  Widget buildYinYaoWidget(int index){
    Curve curve = Curves.easeOutBack; // Curves.easeInOutBack;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: selectedIndex == index ? 28 :24,
          width: (selectedIndex == index ? 168 :140) * 0.46,
          curve: curve,
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
        SizedBox(width: (selectedIndex == index ? 168 :140) * 0.06,),
        // SizedBox(width: (selectedIndex == index ? 180 :168) * 0.06,),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: selectedIndex == index ? 28 :24,
          width: (selectedIndex == index ? 168 :140) * 0.46,
          curve: curve,
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
