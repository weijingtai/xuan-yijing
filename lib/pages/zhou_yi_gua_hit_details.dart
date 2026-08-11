import 'dart:convert';
import 'dart:ui' show ImageFilter;

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:info_popup/info_popup.dart';
import 'package:tuple/tuple.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../databases/MyDatabase.dart';
import '../routes.dart';
import '../widgets/mini_zhou_yi_gua_widget.dart';
import '../widgets/tiny_zhou_yi_gua_widget.dart';
import '../widgets/zhou_yi_gua_widget.dart';
import 'gua_details_page.dart';

class ZhouYiGuaPart extends StatefulWidget {
  late ZhouYi zhouYi;
  double cardWidth;
  ZhouYiGuaPart({Key? key,required this.zhouYi,this.cardWidth = 256}) : super(key: key);

  @override
  State<ZhouYiGuaPart> createState() => _ZhouYiGuaPartState();
}

class _ZhouYiGuaPartState extends State<ZhouYiGuaPart> {
  Logger logger = Logger();
  ValueNotifier<int> _forceDisplayIndex = ValueNotifier(-1);
  ValueNotifier<int> _selectedYaoXiangIndex = ValueNotifier(-1);
  Map<String,InfoPopupController?> infoPopupControllerMapper = {};
  List<GlobalKey> _TooltipKeyList = [];

  @override
  Widget build(BuildContext context) {
    return zhouYiGua(widget.zhouYi.binary,widget.zhouYi.name, GuaSizeType.large,widget.zhouYi.fullname);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _forceDisplayIndex.dispose();
    _selectedYaoXiangIndex.dispose();
  }

  Widget zhouYiGua(String guaBinaryContent,String shortname,GuaSizeType size,String fullname) {
    return InkWell(
      onDoubleTap: (){
        Navigator.pushNamed(context, Routes.zhouyi_details, arguments: {
          'zhouYi': widget.zhouYi
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
        // width: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8,),
              Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          widget.zhouYi.fullname,
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
                        )
                            .animate()
                            .shimmer(duration: 2000.ms,),
                        // .animate(onPlay:((ctl) => ctl.repeat(reverse: false)))
                      ),
                      // Hero(
                      //     tag: "gua_binary_${shortname}",
                      //     child: ZhouYiGuaWidget(guaBinaryContent: guaBinaryContent.split("").reversed.join(""),selectedIndexNotifier: _selectedYaoXiangIndex)
                      // ),
                      ZhouYiGuaWidget(guaBinaryContent: guaBinaryContent.split("").reversed.join(""),selectedIndexNotifier: _selectedYaoXiangIndex),

                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        child: SelectableText(
                          widget.zhouYi.gua.split("：").sublist(1).join(""),
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                          onTap: (){
                            if (_forceDisplayIndex.value != 0) {
                              yaoZhuScrollTo(0);
                              _forceDisplayIndex.value = 0;
                            }else{
                              _forceDisplayIndex.value = -1;
                            }
                          },
                        ),
                      ),
                      Container(
                          width: 640,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4,),
                              InkWell(
                                onTap: (){
                                  if (_forceDisplayIndex.value != 1){
                                    yaoZhuScrollTo(1);
                                    _forceDisplayIndex.value = 1;
                                  }else{
                                    _forceDisplayIndex.value = -1;
                                  }
                                },
                                child:ValueListenableBuilder(
                                  valueListenable: _forceDisplayIndex,
                                  builder: (context, i, child) {
                                    var counter = 1;
                                    return AnimatedContainer(
                                      duration: Duration(milliseconds: 400),
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                      width: 420,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color:  i == counter ?Colors.black.withOpacity(0.4):Colors.transparent,width: 1),
                                        boxShadow: i == counter ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 3,
                                          ),
                                        ]:[],
                                      ),
                                      child: guaTuanWidget(widget.zhouYi.tuan,counter),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 4,),
                              InkWell(
                                onTap: (){
                                  if (_forceDisplayIndex.value != 2){
                                    yaoZhuScrollTo(2);
                                    _forceDisplayIndex.value = 2;
                                  }else{
                                    _forceDisplayIndex.value = -1;
                                  }
                                },
                                child:ValueListenableBuilder(
                                  valueListenable: _forceDisplayIndex,
                                  builder: (context, i, child) {
                                    var counter = 2;
                                    return AnimatedContainer(
                                      duration: Duration(milliseconds: 400),
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                      width: 420,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color:  i == counter ?Colors.black.withOpacity(0.4):Colors.transparent,width: 1),
                                        boxShadow: i == counter ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 3,
                                          ),
                                        ]:[],
                                      ),
                                      child: guaXiangWidget(widget.zhouYi.xiang,2),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                      ),
                      // 卦爻，象
                      FutureBuilder<List<ZhouYiGuaYao>>(
                          future: Get.find<MyDatabase>().findAllGuaYao(guaBinaryContent),
                          builder: (ctx, data){
                            if (data.hasData){
                              if (data.data == null){
                                return Container(
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: Text("error for ${widget.zhouYi.fullname}")
                                );
                              }
                              // logger.d("data.data ${data.data}");
                              return _buildYaoXiang(data.data!);
                            }else{
                              return Container(
                                height: 100,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            }

                          }
                      )
                    ],
                  )
              ),
              SizedBox(height: 12,),
              Container(
                height: 128,
                alignment: Alignment.bottomCenter,
                child: cuoZhongFuZaWidget(guaBinaryContent),
              ),
              SizedBox(height: 12,),
              baGongShiGuaWidget(fullname),
              SizedBox(height: 12,),
              sixteenChangeWidget(fullname),
              SizedBox(height: 12,),
              FutureBuilder(
                future: Get.find<MyDatabase>().findAllSubZhi(guaBinaryContent),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 80,
                      alignment: Alignment.bottomCenter,
                      child: jiaoShiYiLingWidget(snapshot.data),
                    );
                  }else{
                    return Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: 16,),
              FutureBuilder(
                  future: Get.find<MyDatabase>().findAllSingleGuaZhu(widget.zhouYi.binary),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData && snapshot.data != null && snapshot.data.length >= 1) {
                      bool isEmpty = snapshot.data[0].guaZhu == null;
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          color: isEmpty?Colors.transparent:Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isEmpty?Colors.transparent:Colors.black.withOpacity(0.4),width: 1),
                        ),
                        padding: isEmpty?EdgeInsets.zero:EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: isEmpty?Container():Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data[0].guaZhu ?? "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
  Widget guaXiangWidget(String content,int index){
    String xiangContent =content.replaceFirst("《", "").replaceFirst("》", "");
    List<String> xiangList = xiangContent.split("：");
    String xiangName = "${xiangList.first}：";
    String xiang = xiangList.sublist(1).join("");
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(xiangName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(xiang,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                    onTap: (){
                      if (_forceDisplayIndex.value != index){
                        yaoZhuScrollTo(2);
                        _forceDisplayIndex.value = index;
                      }else{
                        _forceDisplayIndex.value = -1;
                      }
                    },),
                ],
              ))
        ],
      ),
    );
  }
  Widget guaTuanWidget(String content,int index){
    String xiangContent = content.replaceFirst("《", "").replaceFirst("》", "");
    List<String> xiangList = xiangContent.split("：");
    String xiangName = xiangList.first + "：";
    String xiang = xiangList.sublist(1).join("");
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(xiangName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(xiang,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                    onTap: (){
                      if (_forceDisplayIndex.value != index){
                        yaoZhuScrollTo(index);
                        _forceDisplayIndex.value = index;
                      }else{
                        _forceDisplayIndex.value = -1;
                      }
                    },),
                ],
              ))
        ],
      ),
    );
  }
  Widget _buildEachGuaYaoCiXiang(int index, String yaoName,String yaoContent,String xiangName,String xiangContent){
    return GestureDetector(
      onTap: (){
        showYaoCard(index);
      },
      child:ValueListenableBuilder(
        valueListenable: _forceDisplayIndex,
        builder: (ctx,i,child){
          return AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color:  i == (index +3) ?Colors.black.withOpacity(0.4):Colors.transparent,width: 1),
              boxShadow: i == (index +3) ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 3,
                ),
              ]:[],
            ),
            child: child!,);
        },
        child:Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          margin: EdgeInsets.symmetric(vertical: 2),
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(yaoName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    // Text(yaoContent,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(yaoContent,
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                              onTap:(){
                                showYaoCard(index);
                              },),
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(xiangName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(xiangContent,
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                              onTap: (){
                                showYaoCard(index);
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // 错综复杂
  Widget cuoZhongFuZaWidget(String guaBinaryContent){
    List<String> lists = guaBinaryContent.split("").toList();
    String cuo = lists.map((e) => e == "1" ? "0" : "1").join("");
    String zong = lists.reversed.join("");
    List<String> ben = guaBinaryContent.split("").toList();
    String hu = [...ben.sublist(1, 4),...ben.sublist(2, 5)].join();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
          future: Get.find<MyDatabase>().getZhouYiByBinary(hu),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _buildCuoZongFuZa(snapshot.data!,'互');
            }else{
              return CardLoading(height: 108,width: 72,borderRadius:BorderRadius.circular(12));
            }
          },
        ),
        FutureBuilder(
          future: Get.find<MyDatabase>().getZhouYiByBinary(cuo),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _buildCuoZongFuZa(snapshot.data!,'错');
            }else{
              return CardLoading(height: 108,width: 72,borderRadius:BorderRadius.circular(12));
            }
          },
        ),
        FutureBuilder(
          future: Get.find<MyDatabase>().getZhouYiByBinary(zong),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _buildCuoZongFuZa(snapshot.data!,'综');
            }else{
              return CardLoading(height: 108,width: 72,borderRadius:BorderRadius.circular(12));
            }
          },
        )
        // _buildCuoZongFuZa(zongFullname,zong,'综'),
      ],
    );
  }
  Widget baGongShiGuaWidget(String fullname){

    return FutureBuilder(
      future:Future.wait([
        DefaultAssetBundle.of(context).loadString("packages/yijing/resources/db/eight_gong_gua_info.json"),
        DefaultAssetBundle.of(context).loadString("packages/yijing/resources/db/gua_fullname_binary_index.json"),
      ]),
      builder: (ctx,snap){
        if (snap.hasData) {
          Map<String,dynamic> eightGuaInfo = json.decode(snap.data![0]) as Map<String,dynamic>;
          Map<String,dynamic> guaFullnameBinaryIndexDB = json.decode(snap.data![1]) as Map<String,dynamic>;
          var pureGuaShortname = eightGuaInfo["index"][fullname];
          List<dynamic> gongGuaList = eightGuaInfo["content"][pureGuaShortname];
          // print(json.encode(gongGuaList));

          var counter = 0;
          Iterable<Tuple4<String,
              String,
              String,
              List<int>>> allGuaList = gongGuaList.map((e) {
            if (guaFullnameBinaryIndexDB[e["name"]] == null) {
              print(e["name"]);
            }
            var rawBinaryLis = guaFullnameBinaryIndexDB[e["name"]] as String;
            String binaryList = rawBinaryLis
                .split("")
                .reversed
                .join("");

            String chuaSubtitle = "";
            switch (counter) {
              case 0:
                chuaSubtitle = "$pureGuaShortname宫纯卦";
                break;
              case 1:
                chuaSubtitle = "一世卦";
                break;
              case 2:
                chuaSubtitle = "二世卦";
                break;
              case 3:
                chuaSubtitle = "三世卦";
                break;
              case 4:
                chuaSubtitle = "四世卦";
                break;
              case 5:
                chuaSubtitle = "五世卦";
                break;
              case 6:
                chuaSubtitle = "游魂卦";
                break;
              case 7:
                chuaSubtitle = "归魂卦";
                break;
            }
            counter += 1;
            return Tuple4<String, String, String, List<int>>(
                binaryList,
                e["name"],
                chuaSubtitle,
                List<int>.from(e["changes"].map((i) => i))
            );
          });
          var guaWidgetList = allGuaList.map((e) =>
              Card(
                  elevation: e.item2 == fullname ? 2 : 0,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: e.item2 == fullname ? Color.fromRGBO(51, 102, 153, .4) : Color.fromRGBO(23, 124, 176, .1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: TinyZhouYiGuaWidget(guaBinaryContent: e.item1,
                          guaName: e.item2,
                          guaExtraName: e.item3,
                          height: 6,
                          width: 48,
                          yaoInterval: 3,
                          changedYaoIndexList: e.item4))
              )).toList();

          return Container(
            width: 512,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: guaWidgetList
              ),
            ),
          );
        }else{
          return CardLoading(height: 64,width: 512,);
        }

      },
    );

  }
  Widget sixteenChangeWidget(String fullname){

    return FutureBuilder(
      future:Future.wait([
        DefaultAssetBundle.of(context).loadString("packages/yijing/resources/db/ba_gong_sixteen_change_info.json"),
        DefaultAssetBundle.of(context).loadString("packages/yijing/resources/db/gua_fullname_binary_index.json"),
      ]),
      builder: (ctx,snap){
        if (snap.hasData) {
          Map<String,dynamic> eightGuaInfo = json.decode(snap.data![0]) as Map<String,dynamic>;
          Map<String,dynamic> guaFullnameBinaryIndexDB = json.decode(snap.data![1]) as Map<String,dynamic>;
          print("-------------${eightGuaInfo["index"][fullname]}");
          var pureGuaShortname = eightGuaInfo["index"][fullname];
          List<dynamic> gongGuaList = eightGuaInfo["content"][pureGuaShortname[1]];
          // print(json.encode(gongGuaList));

          var counter = 0;
          Iterable<Tuple4<String,
              String,
              String,
              List<int>>> allGuaList = gongGuaList.map((e) {
            var rawBinaryLis = guaFullnameBinaryIndexDB[e["name"]] as String;
            String binaryList = rawBinaryLis
                .split("")
                .reversed
                .join("");

            String chuaSubtitle = "";
            switch (counter) {
              case 0:
                chuaSubtitle = "${pureGuaShortname[1]}宫纯卦";
                break;
              case 1:
                chuaSubtitle = "一世卦";
                break;
              case 2:
                chuaSubtitle = "二世卦";
                break;
              case 3:
                chuaSubtitle = "三世卦";
                break;
              case 4:
                chuaSubtitle = "四世卦";
                break;
              case 5:
                chuaSubtitle = "五世卦";
                break;
              case 6:
                chuaSubtitle = "游魂卦";
                break;
              case 7:
                chuaSubtitle = "外戒卦";
                break;
              case 8:
                chuaSubtitle = "内戒卦";
                break;
              case 9:
                chuaSubtitle = "归魂卦";
                break;
              case 10:
                chuaSubtitle = "绝命卦";
                break;
              case 11:
                chuaSubtitle = "血脉卦";
                break;
              case 12:
                chuaSubtitle = "肌肉卦";
                break;
              case 13:
                chuaSubtitle = "骸骨卦";
                break;
              case 14:
                chuaSubtitle = "棺椁卦";
                break;
              case 15:
                chuaSubtitle = "坟墓卦";
                break;
              case 16:
                chuaSubtitle = "还原";
                break;
            }
            counter += 1;
            return Tuple4<String, String, String, List<int>>(
                binaryList,
                e["name"],
                chuaSubtitle,
                List<int>.from(e["changes"].map((i) => i))
            );
          });
          var guaWidgetList = allGuaList.map((e) =>
              Card(
                  elevation: e.item2 == fullname ? 2 : 0,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: e.item2 == fullname ? Color.fromRGBO(74, 66, 102, .4) : Color.fromRGBO(6, 82, 121, .1),
                      ),
                      child: TinyZhouYiGuaWidget(guaBinaryContent: e.item1,
                          guaName: e.item2,
                          guaExtraName: e.item3,
                          height: 6,
                          width: 48,
                          yaoInterval: 3,
                          changedYaoIndexList: e.item4))
              )).toList();

          return Container(
            width: 512,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: guaWidgetList
              ),
            ),
          );
        }else{
          return CardLoading(height: 64,width: 512,);
        }

      },
    );

  }
  Widget _buildCuoZongFuZa(ZhouYi gua,String guaType){

    // Map<String,dynamic> gua = allGua.firstWhere((e) =>  guaFullname.endsWith(e['name']));
    String guaContent = gua.gua.replaceAll("："," ").replaceAll("。", "").replaceAll("，", " ");

    return InfoPopupWidget(
      // contentTitle: huGuaContent,
      customContent: () => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.24),
          borderRadius: BorderRadius.circular(12),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(guaContent,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
      arrowTheme: InfoPopupArrowTheme(
        // color: Colors.pink,
        color: Colors.black.withOpacity(.6),
        arrowDirection: ArrowDirection.down,
      ),
      contentTheme: InfoPopupContentTheme(
        infoContainerBackgroundColor: Colors.black.withOpacity(.6),
        infoTextStyle: TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.all(8),
        contentBorderRadius: BorderRadius.all(Radius.circular(10)),
        infoTextAlign: TextAlign.center,
      ),
      dismissTriggerBehavior: PopupDismissTriggerBehavior.anyWhere,
      areaBackgroundColor: Colors.transparent,
      indicatorOffset: Offset.zero,
      contentOffset: Offset.zero,
      onControllerCreated: (controller) {
        infoPopupControllerMapper[guaType] = controller;
      },
      onAreaPressed: (InfoPopupController controller) {
        // print('Area Pressed');
      },
      infoPopupDismissed: () {
      },
      onLayoutMounted: (Size size) {
      },
      child: Container(
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(2),
          ),
          padding: EdgeInsets.only(top: 2),
          child: InkWell(
              onTap: (){
                if (infoPopupControllerMapper.containsKey(guaType)){
                  infoPopupControllerMapper[guaType]!.isShowing ? infoPopupControllerMapper[guaType]!.dismissInfoPopup() : infoPopupControllerMapper[guaType]!.show();
                }


              },
              onDoubleTap: (){
                Navigator.pushNamed(context, Routes.zhouyi_details, arguments: {
                  'zhouYi': gua,
                });
              },
              child:MiniZhouYiGuaWidget(guaBinaryContent: gua.binary.split("").reversed.join(""),guaName: gua.fullname,guaExtraName: guaType)
          )
      ),
    );
  }
  Widget jiaoShiYiLingWidget(List<JiaoShiYiLin> jiaoLinList){
    // var gua_zhi_map = jiaoShiYiLin[guaShortName];
    List<Widget> listView = [];
    for (int i = 0; i < jiaoLinList.length; i++) {
      JiaoShiYiLin zhi = jiaoLinList[i];
      var guaName = zhi.zhiName;
      var content = zhi.zhiContent;
      var binary = zhi.zhiBinary;
      var currentToolTipKey = GlobalKey();
      _TooltipKeyList.add(currentToolTipKey);

      listView.add(
          Container(
            height: 64,
            width: 48,
            decoration: BoxDecoration(
              color: i == 0 ? Colors.lightBlue.withOpacity(0.4) : Colors.lightBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 4),
              ],
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Tooltip(
                  key: currentToolTipKey,
                  message: content,
                  triggerMode: TooltipTriggerMode.tap,
                  child: TinyZhouYiGuaWidget(guaBinaryContent: binary,guaName: guaName,guaExtraName:null, height: 3,width: 24,yaoInterval: 2)),
            ),
          )
      );
    }
    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 4),
      color: Colors.lightBlue.withOpacity(0.1),
      child:ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
          itemBuilder: (BuildContext context, int index) {
            return listView[index];
          }, itemCount: listView.length),
    );
  }
  Widget _buildYaoXiang(List<ZhouYiGuaYao> yaoList){
    int counter = -1;
    Iterable<Widget> it =  yaoList.map((e){
      List<String> yao = e.yao.split("：");
      // var yaoName ="${yao.first.replaceAll("『", "").replaceAll("』", "")}：";
      var yaoContent = yao.sublist(1).join("");
      List<String> xiang = e.xiang.split("：");
      // var xiangName ="${xiang.first.replaceAll("《", "").replaceAll("》", "")}：";
      var xiangName ="${xiang.first}：";
      var xiangContent = xiang.sublist(1).join("");
      counter++;
      return _buildEachGuaYaoCiXiang(counter,"${e.yaoName}：", yaoContent, xiangName, xiangContent);
    });

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:it.toList(),
      ),
    );
  }
  void yaoZhuScrollTo(int index){
    // _scrollController.animateTo(index *  (widget.cardWidth + 8) , duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    Vibration.vibrate(duration: 100);
  }

  void showYaoCard(int index){
    if (_selectedYaoXiangIndex.value == index) {
      _selectedYaoXiangIndex.value = -1;
      _forceDisplayIndex.value = -1;
    }else{
      _selectedYaoXiangIndex.value = index;
      _forceDisplayIndex.value = index + 3;
      yaoZhuScrollTo(index + 3);
    }
  }
}
