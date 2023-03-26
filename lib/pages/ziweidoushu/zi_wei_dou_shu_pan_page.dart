
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:polygon/polygon.dart';
import 'package:tuple/tuple.dart';

import '../../widgets/polygonal.dart';

class ZiWeiDouShuPanPage extends StatefulWidget {
  const ZiWeiDouShuPanPage({Key? key}) : super(key: key);

  @override
  State<ZiWeiDouShuPanPage> createState() => _ZiWeiDouShuPanPageState();
}

class _ZiWeiDouShuPanPageState extends State<ZiWeiDouShuPanPage> {
  @override
  Widget build(BuildContext context) {
    DateTime yangStartTime = DateTime.now();
    String yangStartTimeStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(yangStartTime);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight  = MediaQuery.of(context).size.height;
    double totalWidth = (screenWidth <= screenHeight ? screenWidth : screenHeight) - 16;
    double eachCellWidth = totalWidth / 4;
    double centerSize = totalWidth * .5;
    return Scaffold(
      // appBar: AppBar(
      //   title: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('紫微斗数·天盘'),
      //       Text(yangStartTimeStr),
      //     ],
      //   )
      // ),
      body: Container(
        width: totalWidth,
        height: totalWidth,
        alignment: Alignment.center,
        child:Column(
          children: [
            Row(
              children: [
                eachCell('命宫',eachCellWidth,eachCellWidth),
                eachCell('兄弟',eachCellWidth,eachCellWidth),
                eachCell('夫妻',eachCellWidth,eachCellWidth),
                eachCell('子女',eachCellWidth,eachCellWidth),
              ],
            ),
            Container(
              width: totalWidth,
              height: centerSize,
              child: Row(
                children: [
                  Column(
                    children: [
                      eachCell('父母',eachCellWidth,eachCellWidth),
                      eachCell('福德',eachCellWidth,eachCellWidth),
                    ],
                  ),
                  Container(
                    width: centerSize,
                    height: centerSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black38, width: .5),
                    ),
                    child:centerCell(centerSize),
                  ),
                  Column(
                    children: [
                      eachCell('财帛',eachCellWidth,eachCellWidth),
                      eachCell('疾厄',eachCellWidth,eachCellWidth),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                eachCell('田宅',eachCellWidth,eachCellWidth),
                eachCell('官禄',eachCellWidth,eachCellWidth),
                eachCell('奴仆',eachCellWidth,eachCellWidth),
                eachCell('迁移',eachCellWidth,eachCellWidth),
              ],
            ),


          ],
        )
      )
    );
  }
  Widget eachCell(String content,double width,double height){
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: content == "命宫"?Colors.blue[100]:Colors.white,
        border: Border.all(color: Colors.black38, width: .5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            content,
            style: TextStyle(
              color: Colors.black12,
              fontSize: 56,
            ),
          ),
          gongDetail()
        ],
      ),
    );
  }
  Widget gongDetail(){
    return Column(
      children: [
        Expanded(
            flex:3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  xingName("天相得",Colors.red,Colors.black87),
                  xingName("天钺旺",Colors.deepOrangeAccent,Colors.black87),
                  xingName("天马平",Colors.deepOrangeAccent,Colors.black87),
                  xingName("天福",Colors.deepOrangeAccent,Colors.black87),
                  xingName("天巫",Colors.brown,Colors.black87),
                  xingName("孤辰",Colors.brown,Colors.black87),
                  xingName("蜚廉",Colors.brown,Colors.black87),
                  xingName("破碎",Colors.brown,Colors.black87),
                  xingName("三台",Colors.brown,Colors.black87),
                  xingName("旬空",Colors.brown,Colors.black87),
                ],
              ),)),

        Expanded(
            flex:1,
            child:
            Container(
                alignment:Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                              color: Colors.redAccent.withOpacity(0.4),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 1
                          ),
                        ],
                        shape: PolygonBorder(
                          polygon: RegularStarPolygon(
                            vertexCount: 12,
                            ratio: 0.8,
                          ),
                          radius: 42,
                        ),
                        color: Colors.redAccent,
                      ),
                      child: Container(
                          width: 36,
                          height: 36,
                          alignment:Alignment.center,
                          child:Text("权",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.3,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0, 0),
                                      blurRadius: 3
                                  ),
                                ]),)),
                    ).animate().scale(delay:Duration(milliseconds: 2000),curve: Curves.easeOutBack,duration: Duration(milliseconds: 300)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boShi12(),
                        jiangQian12(),
                        suiQian12(),
                      ],
                    ),
                    Container(width: 36),
                  ],
                )
            )
        ),
        Expanded(
            flex:1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 3),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Icon(Icons.verified,color: Colors.red,size: 32,),
                  jiaZi60(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          offset: Offset(0, 0),
                          blurRadius: 3,
                          spreadRadius: 1
                        ),
                      ],
                    ),
                    child:Text(
                        "25~34",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        // height: 1.3,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(0, 0),
                            blurRadius: 3
                          ),
                        ]
                      ),
                    )
                  ),
                  zhangSheng12(),
                ],
              ),
            )
        ),
      ],
    );
  }
  // 博士 12
  Widget boShi12(){
    var boShiList = <String>[ "博士",
      "力士",
      "青龙",
      "小耗",
      "将军",
      "奏书",
      "飞廉",
      "喜神",
      "病符",
      "大耗",
      "伏兵",
      "官符",
    ];
    return tag(Text(
      boShiList.first,
      style: TextStyle(color: Colors.indigo,fontSize: 16),
    ));


  }
  // 将前 12
  Widget jiangQian12(){
    var jiangQianList = <String>["将星",
    "攀鞍",
    "岁驿",
    "息神",
    "华盖",
    "劫煞",
    "灾煞",
    "天煞",
    "指背",
    "咸池",
    "月煞",
    "亡神",
    ];
    return tag(Text(
      jiangQianList.first,
      style: TextStyle(color: Colors.blueGrey,fontSize: 16),
    ));
  }
  // 岁前 12
  Widget suiQian12(){
    var suiQianList = <String>["岁建","晦气","丧门","贯索","官符","小耗","大耗","龙德","白虎","天德","吊客","病符"];
    return tag(Text(
      suiQianList.first,
      style: TextStyle(color: Colors.teal,fontSize: 16),
    ));
  }
  // 长生
  Widget zhangSheng12(){
    var suiQianList = <String>["长生","沐浴","冠带","临官","帝旺","衰","病","死","墓","绝","胎","养"];
    return tagFormat(Text(
      suiQianList.first,
      style: TextStyle(color: Colors.white,fontSize: 16),
    ),Colors.teal.withOpacity(0.4));

  }

  Widget jiaZi60(){
    return tagFormat(Text(
      "甲寅",
      style: TextStyle(color: Colors.white,fontSize: 16),
    ), Colors.blue.withOpacity(0.4));
  }

  Widget tag(Widget child){
    return tagFormat(
        child,
        Colors.white
    );
  }
  Widget tagFormat(Widget child, Color color){
    return Container(
      padding: EdgeInsets.only(left: 4,right: 4,top: 1,bottom: 2),
      margin: EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget xingName(String name,Color nameColor,Color? extraNameColor){
    List<String> nameList = name.split("");
    RichText? content;
    TextStyle textStyle = TextStyle(color: nameColor,height: 1,fontSize: 14);
    if (nameList.length == 2){
      content = RichText(text: TextSpan(text: nameList.join("\n"),style: textStyle),);
    }else{
      List<String> finalNameList = nameList.sublist(0, 2);
      content = RichText(text: TextSpan(text: finalNameList.join("\n"),style: textStyle,children: [TextSpan(text:"\n${nameList.last}",style: TextStyle(color: extraNameColor))]));
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
      margin: EdgeInsets.only(right: 1,bottom: 4,top: 2,left: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: content,
    );

  }

  Widget centerCell(double size){
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(
      ),
      child:Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.only(right: 24),
                          child:Column(
                            children: [
                              Expanded(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text:TextSpan(
                                          text: '命四化',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "【癸破巨阴贪】",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                        )),
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: '盘类：',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: "天盘 "),
                                          TextSpan(text: " 土五局 "),
                                          TextSpan(text: " 子斗在酉 "),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: '阳历：',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: '2023', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "年"),
                                          TextSpan(text: '02', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "月"),
                                          TextSpan(text: '04', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "日"),
                                          TextSpan(text: '17', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "时"),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: '农历：',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: '癸卯', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "年"),
                                          TextSpan(text: '正', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "月"),
                                          TextSpan(text: '十四', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "日"),
                                          TextSpan(text: '酉', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: "时"),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          )
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child:Column(
                            children: [
                              Expanded(child: Container(child: Text("命宫在巳"),)),
                              Expanded(child: Container(child: Text("身宫在亥"),)),
                              Expanded(child: Container(child: Text("命主武曲"),)),
                              Expanded(child: Container(child: Text("身主天同"),)),
                            ],
                          )
                        )),
                    Expanded(child: Container(
                      margin: EdgeInsets.only(left: 8),
                      alignment: Alignment.topRight,
                      child: SelectableText.rich(
                          TextSpan(
                            // text: '年',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "1",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            TextSpan(
                              text: "岁",
                            ),
                            ],
                          )),
                    ))
                  ],
                )
              )
          ),
          Expanded(
              flex: 4,
              child: Container(
                // color: Colors.green[200],
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.green[600],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 28 * 3,
                              child: Column(
                                children: [
                                  Expanded(child: Container(child: Text("",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("乾造",style: TextStyle(fontSize: 16)),)),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 28 * 3,
                              child: Column(
                                children: [
                                  Expanded(child: Container(child: Text("金箔金",style: TextStyle(fontSize: 16)))),
                                  Expanded(child: Container(child: Text("比肩",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("癸卯",style: TextStyle(fontSize: 16)),)),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(height: 28,child: RichText(text: TextSpan(text:"乙",style: TextStyle(fontSize: 16),children: [TextSpan(text:"食神",style: TextStyle(color: Colors.blue))]))),
                              ],
                            ),)


                          ],
                        ),
                      ),),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 28 * 3,
                              child: Column(
                                children: [
                                  Expanded(child: Container(child: Text("大溪水",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("伤官",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("甲寅",style: TextStyle(fontSize: 16)),)),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(height: 28, child: RichText(text: TextSpan(text:"甲",style: TextStyle(fontSize: 16),children: [TextSpan(text:"伤官",style: TextStyle(color: Colors.blue))]))),
                                Container(height: 28, child: RichText(text: TextSpan(text:"丙",style: TextStyle(fontSize: 16),children: [TextSpan(text:"正财",style: TextStyle(color: Colors.blue))]))),
                                Container(height: 28, child: RichText(text: TextSpan(text:"戊",style: TextStyle(fontSize: 16),children: [TextSpan(text:"正官",style: TextStyle(color: Colors.blue))]))),
                              ],
                            ),)

                          ],
                        ),
                      ),),
                    Expanded(
                      child: Container(
                        // color: Colors.green[600],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 28 * 3,
                              child: Column(
                                children: [
                                  Expanded(child: Container(child: Text("长流水",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("日主",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("癸巳",style: TextStyle(fontSize: 16)),)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(height: 28, child: RichText(text: TextSpan(text:"庚",style: TextStyle(fontSize: 16),children: [TextSpan(text:"正印",style: TextStyle(color: Colors.blue))]))),
                                  Container(height: 28, child: RichText(text: TextSpan(text:"丙",style: TextStyle(fontSize: 16),children: [TextSpan(text:"正财",style: TextStyle(color: Colors.blue))]))),
                                  Container(height: 28, child: RichText(text: TextSpan(text:"戊",style: TextStyle(fontSize: 16),children: [TextSpan(text:"正官",style: TextStyle(color: Colors.blue))]))),
                                ],
                              ),)
                          ],
                        ),
                      ),),
                    Expanded(
                      child: Container(
                        width: 28,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 28 * 3,
                              child: Column(
                                children: [
                                  Expanded(child: Container(child: Text("石榴木",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("枭神",style: TextStyle(fontSize: 16)),)),
                                  Expanded(child: Container(child: Text("辛酉",style: TextStyle(fontSize: 16)),)),
                                ],
                              ),
                            ),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Container(child: RichText(text: TextSpan(text:"辛",style: TextStyle(fontSize: 16),children: [TextSpan(text:"枭神",style: TextStyle(color: Colors.blue))])),)),
                              ],
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex:2,
                        child:Container(
                          alignment:Alignment.centerLeft,
                          child: Text("大运【03月换运】："),
                        )),
                    Expanded(
                        flex:6,
                        child:SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Tuple4("癸丑","比肩",2023,1),
                                Tuple4("壬子","劫财",2033,11),
                                Tuple4("辛亥","枭神",2043,21),
                                Tuple4("庚戌","正印",2053,31),
                                Tuple4("己酉","七杀",2063,41),
                                Tuple4("戊申","正官",2073,51),
                                Tuple4("丁未","偏财",2083,61),

                                Tuple4("己酉","七杀",2093,71),
                                Tuple4("戊申","正官",2103,81),
                                Tuple4("丁未","偏财",2113,91),
                              ].asMap().entries.map((entry) => Container(
                                // margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                color: entry.key.isOdd?Colors.blue[100]:Colors.transparent,
                                child: Column(
                                  children: [
                                    Expanded(child: Container(child: Text(entry.value.item1,style: TextStyle(fontSize: 16),),)),
                                    Expanded(child: Container(child: Text(entry.value.item2,style: TextStyle(fontSize: 16)),)),
                                    Expanded(child: Container(child: Text("${entry.value.item3}",style: TextStyle(fontSize: 16)),)),
                                    Expanded(child: Container(child: Text("${entry.value.item4}",style: TextStyle(fontSize: 16)),)),
                                  ],
                                ),
                              )).toList()
                          ),
                        ))
                  ]
              )),
        ],
      )
    );

  }
}
