
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:info_popup/info_popup.dart';
import 'package:my_flutter/widgets/tiny_zhou_yi_gua_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes.dart';
import '../widgets/mini_zhou_yi_gua_widget.dart';
import '../widgets/small_zhou_yi_gua_widget.dart';
import '../widgets/zhou_yi_gua_widget.dart';

class ZhouYiGuaDetailsPage extends StatefulWidget {
  late String guaName;
  late String content;
  late String tuan;
  late String xiang;
  late List<dynamic> yao_list;
  ZhouYiGuaDetailsPage(Map<String, dynamic> args, {Key? key}) : super(key: key){
    guaName = args["name"];
    content = args["content"];
    tuan = args["tuan"]['content'];
    xiang = args["xiang"]['content'];
    yao_list = args["yao_list"] as List<dynamic>;

  }

  @override
  State<ZhouYiGuaDetailsPage> createState() => _ZhouYiGuaDetailsPageState();
}

class _ZhouYiGuaDetailsPageState extends State<ZhouYiGuaDetailsPage> with TickerProviderStateMixin {
  final Duration _selectedAnimationDuration = const Duration(milliseconds: 300);
  final List<String> liuShou = ["青龙","白虎","朱雀","玄武","勾陈","螣蛇"];
  final List<String> liuQin = ["父母","子孙","兄弟","妻财","官鬼"];

  late AnimationController _firstScallController;
  ScrollController _scrollController = ScrollController();

  String content = ""; // 点击放大的文本
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstScallController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

  }
  @override
  void dispose() {
    _firstScallController.dispose();
    displayZhuNotifier.dispose();
    _selectedYaoXiangIndex.dispose();
    _forceDisplayIndex.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  ValueNotifier<Tuple4<String,String,String,String>?> displayZhuNotifier = ValueNotifier(null);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: loadJsonDB(),
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
              // showToast("snapshot.hasData: ${snapshot.hasData}");
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError){
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              return buildRealBody(snapshot.data!);
            },

          ),
          ValueListenableBuilder(
              valueListenable: displayZhuNotifier,
              builder: (ctx,displayZhu,child){
            if (displayZhu != null){
              return GestureDetector(
                onDoubleTap: (){
                  displayZhuNotifier.value = null;
                },
                child: GlassContainer(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  opacity: 0.2,
                  color: Colors.black.withOpacity(.2),
                  blur: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.height * 0.6,
                          child:Card(
                            elevation: 8,
                            child: InkWell(
                              // onTap: ()=>Navigator.pop(context),
                              // onDoubleTap: ()=>Navigator.pop(context),
                                child: Column(
                                    children:[
                                      Container(
                                          margin: EdgeInsets.symmetric(vertical: 8),
                                          child:Text("《${displayZhu.item1}·${displayZhu.item2}·${displayZhu.item3}》")
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.height * 0.6,
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        // color: Colors.blue[(1+index) * 100],
                                        padding: EdgeInsets.only(left: 16,right: 0,top: 16,bottom: 16),
                                        // child: Text(["彖","象","初","二","三","四","五","上"][index]),
                                        child:SelectableText.rich(
                                          TextSpan(text: displayZhu.item4,style: TextStyle(fontSize: 20)),
                                          // onTap: ()=>Navigator.pop(context),
                                          onSelectionChanged: (selection,cause){
                                            int selectFromIndex = selection.baseOffset;
                                            int selectToIndex = selection.extentOffset;
                                            showToast("selection changed: ${content.substring(selectFromIndex,selectToIndex)}");
                                          },
                                          contextMenuBuilder: contentSelected,),
                                      ),
                                    ]
                                )
                            ),
                          )
                      )
                    ],
                  ),
                )
              );
            }
            return Container();
          })
        ],
      )
    );
  }
  AdaptiveLayout buildRealBody(Map<String,dynamic> db){

    if ( guaShortnameBinaryIndexDB[widget.guaName] == null){
      return AdaptiveLayout(
        // Body switches between a ListView and a GridView from small to medium
        // breakpoints and onwards.
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('Body2 Medium'),
                builder: (_) => Container(
                  child: Text(guaShortnameBinaryIndexDB[widget.guaName]),
                )
            ),
          },
        ),
        secondaryBody: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.large: SlotLayout.from(
                key: const Key('SecondaryBody2 large'),
                builder: (_) =>Container(
                  child: Text(guaShortnameBinaryIndexDB[widget.guaName]),
                )
            ),
          },
        ),
        // BottomNavigation is only active in small views defined as under 600 dp
        // width.
      );
    }
    String reversedBinaryContent = guaShortnameBinaryIndexDB[widget.guaName];
    // List<String> binaryContentList =List.;
    // String binaryContent = binaryContentList.join("");
    String binaryContent = reversedBinaryContent;
    var guaName = widget.guaName;
    Map<String,dynamic> allInfo = db[guaName];
    return AdaptiveLayout(
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
              key: const Key('Body2 Small'),
              builder: (_) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: zhouYiGua(binaryContent,widget.guaName,"本", GuaSizeType.large),
                    ),
                    SliverToBoxAdapter(
                      child:  Container(
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: allInfo.entries.map((e) => Container(
                                      height: 256,
                                      alignment: Alignment.center,
                                      color: Colors.green[100],
                                      padding: EdgeInsets.only(bottom: 24),
                                      child: Column(
                                        children: [
                                          Container(height:24,alignment: Alignment.center,child: Text("《${e.key}》")),
                                          Container(
                                              height: 256-24-24,
                                              child:ListView.builder(itemBuilder: (context, index) =>InkWell(
                                                onTap: (){
                                                  showToast("tap");
                                                },
                                                child: Card(
                                                    child: Container(
                                                      // height: 128,
                                                      width: 256,
                                                      child: Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            height: 200,
                                                            width: 256,
                                                            alignment: Alignment.center,
                                                            child: Text("${["卦","彖","象","初","二","三","四","五","上"][index]}",style: TextStyle(fontSize: 72,color: Colors.black12),),
                                                          ),
                                                          Container(
                                                            height: 200,
                                                            width: 256,
                                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                                            alignment: Alignment.center,
                                                            // color: Colors.blue[(1+index) * 100],
                                                            padding: EdgeInsets.only(left: 4,right: 0,top: 8,bottom: 8),
                                                            // child: Text(["象","彖","初","二","三","四","五","上"][index]),
                                                            child: SelectableText.rich(
                                                                TextSpan(text: (e.value[index]["zhu"] == null || e.value[index]["zhu"].length == 0)?"": e.value[index]["zhu"]),
                                                                contextMenuBuilder: contentSelected,
                                                                onTap:(){
                                                                  content = e.value[index]["zhu"];
                                                                  if (e.value[index]["zhu"] == null || e.value[index]["zhu"].length == 0){
                                                                    return;
                                                                  }
                                                                  showGeneralDialog(
                                                                    context: context,
                                                                    barrierColor: Colors.black12.withOpacity(0.6), // Background color
                                                                    barrierDismissible:true ,
                                                                    barrierLabel: "《${e.key}·$guaName·${e.value[index]['name']}》",
                                                                    transitionDuration: Duration(milliseconds: 400),
                                                                    pageBuilder: (_, __, ___) {
                                                                      return Dialog(
                                                                          child:InkWell(
                                                                            // onTap: ()=>Navigator.pop(context),
                                                                            // onDoubleTap: ()=>Navigator.pop(context),
                                                                              child: Column(
                                                                                  children:[
                                                                                    Text("《${e.key}·$guaName·${e.value[index]['name']}》"),
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.height * 0.6,
                                                                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                                                                      // color: Colors.blue[(1+index) * 100],
                                                                                      padding: EdgeInsets.only(left: 16,right: 0,top: 16,bottom: 16),
                                                                                      // child: Text(["彖","象","初","二","三","四","五","上"][index]),
                                                                                      child:SelectableText.rich(
                                                                                        TextSpan(text: e.value[index]["zhu"]),
                                                                                        // onTap: ()=>Navigator.pop(context),
                                                                                        onSelectionChanged: (selection,cause){
                                                                                          int selectFromIndex = selection.baseOffset;
                                                                                          int selectToIndex = selection.extentOffset;
                                                                                          showToast("selection changed: ${content.substring(selectFromIndex,selectToIndex)}");
                                                                                        },
                                                                                        contextMenuBuilder: contentSelected,),
                                                                                    ),
                                                                                  ]
                                                                              )
                                                                          )
                                                                      );
                                                                    },
                                                                  );
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ),itemCount: e.value.length,scrollDirection: Axis.horizontal,)
                                          ),
                                        ],
                                      )
                                  )).toList()
                              )
                          )
                      ),
                    ),
                  ]
              )
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('Body2 Medium'),
              builder: (_) => InkWell(
                onTap: (){
                  if (selectedIndex != -1){
                    setState(() {
                      selectedIndex = -1;
                    });
                  }                },
                child: Listener(
                  onPointerHover: (event){
                    // showToast("main hover",position: ToastPosition.bottom);
                  },
                  child:zhouYiGua(binaryContent,widget.guaName,"本", GuaSizeType.large),
                ),
              )
          ),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('SecondaryBody2 large'),
              builder: (_) {
                return Container(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: allInfo.entries.map((e) => Container(
                                height: 256,
                                alignment: Alignment.center,
                                // color: Colors.green[100],
                                padding: EdgeInsets.only(bottom: 24),
                                child: Column(
                                  children: [
                                    Container(height:24,alignment: Alignment.center,child: Text("《${e.key}》")),
                                    Container(
                                        height: 256-24-24,
                                        child:ListView.builder(
                                            controller: _scrollController,
                                          itemBuilder: (context, index) =>InkWell(
                                          onTap: (){
                                            var currentIndex =  index - 3;
                                            if (currentIndex != _selectedYaoXiangIndex.value){
                                              yaoZhuScrollTo(index);
                                              _forceDisplayIndex.value = index;
                                            }
                                          },
                                          onDoubleTap: (){
                                            if (e.value[index]["zhu"] != null){
                                              content = e.value[index]["zhu"];
                                              if (content.isNotEmpty){
                                                popupYaoZhu(e.key,widget.guaName, e.value[index]["zhu"], e.value[index]["name"]);
                                              }
                                            }
                                          },
                                          child: ValueListenableBuilder(
                                            valueListenable:_forceDisplayIndex,
                                              builder:(ctx,value,_){
                                              return AnimatedContainer(
                                                  duration:Duration(milliseconds: 400),
                                                curve: Curves.easeInOut,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                  border: value == index ?Border.all(color: Colors.black.withOpacity(.4),width:1):Border.all(color: Colors.transparent,width:1),
                                                  color: Colors.white,
                                                    boxShadow: value == index ?[
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 6,
                                                        offset: Offset(1, 1), // changes position of shadow
                                                      ),
                                                    ]:[]
                                                ),
                                                // height: 128,
                                                width: 256,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      width: 256,
                                                      alignment: Alignment.center,
                                                      child: Text(["卦","彖","象","初","贰","叁","肆","伍","上"][index],style: TextStyle(fontSize: 72,color: e.value[index]["zhu"] == null ?Colors.black38:Colors.black.withOpacity(0.2)),),
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      width: 256,
                                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                                      alignment: Alignment.center,
                                                      // color: Colors.blue[(1+index) * 100],
                                                      padding: EdgeInsets.only(left: 4,right: 0,top: 8,bottom: 8),
                                                      // child: Text(["象","彖","初","二","三","四","五","上"][index]),
                                                      child: SelectableText.rich(
                                                        TextSpan(text: (e.value[index]["zhu"] == null || e.value[index]["zhu"].length == 0)?"": e.value[index]["zhu"]),
                                                        contextMenuBuilder: contentSelected,
                                                        onTap: (){
                                                          // var currentIndex =  index - 3;
                                                          if (index != _forceDisplayIndex.value){
                                                            yaoZhuScrollTo(index);
                                                            _forceDisplayIndex.value = index;
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          ),
                                        ),itemCount: e.value.length,scrollDirection: Axis.horizontal,)
                                    ),
                                  ],
                                )
                            )).toList()
                        )
                    )
                );
              }
          ),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
    );
  }
  void popupYaoZhu(String bookname, String guaName, String zhu, String contentName){
    displayZhuNotifier.value = Tuple4(bookname, guaName, contentName, zhu);
  }

  Map<String,dynamic> guaNameZhuJieMap = {};


  Map<String,dynamic> guaFullnameBinaryIndexDB = {};
  Map<String,dynamic> guaBinaryFullnameIndexDB = {};
  Map<String,dynamic> guaShortnameBinaryIndexDB = {};
  Map<String,dynamic> yiTongZiWen = {};
  Map<String,dynamic> jiaoShiYiLin = {};

  List<Map<String, dynamic>> allGua = <Map<String,dynamic>>[];

  // 八宫卦信息
  // 包含两种key 1. content (以纯卦为key的list, list 是{"name":"<全名>","changes":[<改变的爻>，-1为纯卦本身，没有改变]})
  // key 2. index {"<卦全名>":"<所属纯卦简称>"}
  Map<String,dynamic> eightGuaInfo = {};

  Future<Map<String,dynamic>> loadJsonDB() async {
    var allLoads = await Future.wait([
      DefaultAssetBundle.of(context).loadString("resources/db/gua_name_index_v1_1.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/gua_fullname_binary_index.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/gua_shortname_binary_index.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/yi_tong_zi_wen_v1_1.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/焦氏易林.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/gua_binary_fullname_index.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/eight_gong_gua_info.json"),
      DefaultAssetBundle.of(context).loadString("resources/db/all_gua_v1.json"),
    ]);
    guaNameZhuJieMap = json.decode(allLoads[0]) as Map<String,dynamic>;
    guaFullnameBinaryIndexDB = json.decode(allLoads[1]) as Map<String,dynamic>;
    guaShortnameBinaryIndexDB = json.decode(allLoads[2]) as Map<String,dynamic>;
    yiTongZiWen = json.decode(allLoads[3]) as Map<String,dynamic>;
    jiaoShiYiLin = json.decode(allLoads[4]) as Map<String,dynamic>;
    guaBinaryFullnameIndexDB = json.decode(allLoads[5]) as Map<String,dynamic>;
    eightGuaInfo = json.decode(allLoads[6]) as Map<String,dynamic>;
    allGua = (jsonDecode(allLoads[7]) as List).map((e) => e as Map<String, dynamic>).toList();
    // convert string to json map object
    // dynamic jsonRes = json.decode(data);
    return guaNameZhuJieMap;
  }

  DateTime lastPenHoverAt = DateTime.now();
  Duration? lastEnterHoverTimestamp;
  int selectedIndex = -1;
  String listenerText = "";
  Color currentColor = Colors.blue;
  Color defaultColor = Colors.blue;
  Color defaultPenHover = Colors.redAccent;
  Timer? penMouseHoverTimer;
  // guaBinaryContent should like "101010" with length 6,
  // and the first number is the bottom yao
  Widget zhouYiGua(String guaBinaryContent,String shortname,String guaType, GuaSizeType size) {

    List<int> guaBinaryIter = guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    guaBinaryContent = guaBinaryIter.reversed.join("");
    String guaFullname = guaBinaryFullnameIndexDB[guaBinaryContent.split("").toList().reversed.join()];
    return Container(
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
                        guaFullname,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ZhouYiGuaWidget(guaBinaryContent: guaBinaryContent,selectedIndexNotifier: _selectedYaoXiangIndex),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        child: SelectableText(
                          widget.content.split("：").sublist(1).join(""),
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
                    ),
                    Container(
                        width: 640,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(widget.xiang.replaceFirst("《", "").replaceFirst("》", ""),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            // Text(widget.tuan.replaceFirst("《", "").replaceFirst("》", ""),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
                                    child: guaTuanWidget(widget.tuan,counter),
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
                                    child: guaXiangWidget(widget.xiang,2),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    // 卦爻注
                    _buildYaoXiang(),
                  ],
                )
            ),
            SizedBox(height: 24,),
            Container(
              height: 160,
              alignment: Alignment.bottomCenter,
              child: cuoZhongFuZaWidget(guaBinaryContent),
            ),
            baGongShiGuaWidget(guaFullname),
            jiaoShiYiLingWidget(shortname),
          ],
        ),
      ),
    );
  }
  // 爻辞， 爻象
  Widget _buildYaoXiang(){
    int counter = -1;
    Iterable<Widget> it =  widget.yao_list.map((e){
      List<String> yao = e['yao'].split("：");
      var yaoName ="${yao.first.replaceAll("『", "").replaceAll("』", "")}：";
      var yaoContent = yao.sublist(1).join("");
      List<String> xiang = e['yao_xiang'].split("：");
      var xiangName ="${xiang.first.replaceAll("《", "").replaceAll("》", "")}：";
      var xiangContent = xiang.sublist(1).join("");
      counter++;
      return _buildEachGuaYaoCiXiang(counter,yaoName, yaoContent, xiangName, xiangContent);
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
  ValueNotifier<int> _selectedYaoXiangIndex = ValueNotifier(-1);
  // 象 0， 彖 1 ， 爻 2,3,4,5,6,7
  ValueNotifier<int> _forceDisplayIndex = ValueNotifier(-1);
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
                    // Text(xiangContent,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
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
    return ValueListenableBuilder(
      valueListenable: _selectedYaoXiangIndex,
      builder: (ctx,i,child){
        return  Card(
          elevation: i == index ? 6: 0,
          color: Colors.white,
          child: child!,
        );
      },
      child: GestureDetector(
        onTap: (){
          showYaoCard(index);
        },
        child: Container(
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
                    // Text(xiangContent,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
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
  void yaoZhuScrollTo(int index){
    _scrollController.animateTo(index *  (256 + 16) , duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
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

  // 错综复杂
  Widget cuoZhongFuZaWidget(String guaBinaryContent){
    List<String> lists = guaBinaryContent.split("").toList();
    String cuo = lists.map((e) => e == "1" ? "0" : "1").join("");
    String cuoFullname = guaBinaryFullnameIndexDB[cuo.split("").reversed.join()];
    String zong = lists.reversed.join("");
    String zongFullname = guaBinaryFullnameIndexDB[lists.join("")];
    List<String> ben = guaBinaryContent.split("").toList();
    List<String> top = ben.sublist(1, 4);
    List<String> bottom = ben.sublist(2, 5);
    List<String> res = top..addAll(bottom);
    String hu = res.join();
    String huFullname = guaBinaryFullnameIndexDB[res.reversed.join()];
    guaBinaryContent.split("").toList()..reversed.toList();
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCuoZongFuZa(huFullname,hu,'互'),
        _buildCuoZongFuZa(cuoFullname,cuo,'错'),
        _buildCuoZongFuZa(zongFullname,zong,'综'),
      ],
    );
  }
  InfoPopupController? _huPopupController;
  InfoPopupController? _couPopupController;
  InfoPopupController? _zongPopupController;

  Widget _buildCuoZongFuZa(String guaFullname,String binary,String guaType){

    Map<String,dynamic> gua = allGua.firstWhere((e) =>  guaFullname.endsWith(e['name']));
    String guaContent = gua["content"].replaceAll("："," ").replaceAll("。", "").replaceAll("，", " ");


    return InfoPopupWidget(
      // contentTitle: huGuaContent,
      customContent:GlassContainer(
        color: Colors.black.withOpacity(0.6),
        blur: 0.8,
        opacity: 0.4,
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
        if (guaType == "互") {

          _huPopupController = controller;
        } else if (guaType == "错") {
          _couPopupController = controller;
        } else if (guaType == "综") {
          _zongPopupController = controller;
        }
        print('Info Popup Controller Created');
      },
      onAreaPressed: (InfoPopupController controller) {
        print('Area Pressed');
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
              if (guaType == "互") {
                if (_huPopupController != null){
                  if (_huPopupController!.isShowing) {
                    _huPopupController!.dismissInfoPopup();
                  }else{
                    _huPopupController!.show();
                  }
                }
                _huPopupController?.show();
              } else if (guaType == "错") {
                if (_couPopupController != null){
                  if (_couPopupController!.isShowing) {
                    _couPopupController!.dismissInfoPopup();
                  }else{
                    _couPopupController!.show();
                  }
                }
              } else if (guaType == "综") {
                if (_zongPopupController != null){
                  if (_zongPopupController!.isShowing) {
                    _zongPopupController!.dismissInfoPopup();
                  }else{
                    _zongPopupController!.show();
                  }
                }
              }

            },
            onDoubleTap: (){
              Navigator.pushNamed(context, Routes.zhouyi_details, arguments: {
                'name': gua['name'],
                'content': gua['content'],
                'tuan': gua['tuan'],
                'xiang': gua['xiang'],
                'yao_list': gua['yao_list'],
              });
            },
              child:MiniZhouYiGuaWidget(guaBinaryContent: binary,guaName: guaFullname,guaExtraName: guaType)
          )
    ),
    );
  }

  Widget penHoverScale(String cuoBinaryContent, String cuoFullname){
    return MouseRegion(
        onHover: (event){
          if (lastEnterHoverTimestamp == null){
            // showToast("start gua hover");
            lastEnterHoverTimestamp = event.timeStamp;
          }
          else{
            lastPenHoverAt = DateTime.now();
            var hoverOnMillisCounter = event.timeStamp.inMilliseconds - lastEnterHoverTimestamp!.inMilliseconds;
            if (hoverOnMillisCounter >= 1000){
              listenerText = "hover $lastPenHoverAt ${_firstScallController.status.name}";
              if (penMouseHoverTimer != null){
                showToast("already started.",position: ToastPosition.top);
                return;
              }
              showToast("gua hover 3s, start scale up");
              currentColor = defaultPenHover;
              // forward() 必须在 penMousHoverTimer 赋值后 调用，
              // 由于 flutter_animate 框架的原因，forward() 会自动调用forward()，不会等待手动 animationController.forward()
              // 所以 为了防止UI在第一帧就显示被放大结果，所以判断 '_firstScallController.status == AnimationStatus.forward && penMouseHoverTimer == null'
              // 为true时 调用_firstScallController.reset()，组织 flutter_animate 的自动调用forward()
              penMouseHoverTimer ??= Timer.periodic(Duration(milliseconds: 500), (timer) {
                var now = DateTime.now();
                if (lastPenHoverAt.add(Duration(seconds:2)).isBefore(now)){
                  timer.cancel();
                  currentColor = defaultColor;
                  listenerText = "";
                  penMouseHoverTimer = null;
                  lastEnterHoverTimestamp = null;
                  if (_firstScallController.isCompleted){
                    _firstScallController.reverse();
                    showToast("timer hover left",duration: Duration(seconds: 2));
                  }
                }else if (lastPenHoverAt.add(Duration(seconds:1)).isBefore(now)){
                  if (_firstScallController.isAnimating){
                    showToast("timer hover left before scale up ${lastPenHoverAt.add(Duration(seconds:2)).isAfter(now)}",duration: Duration(seconds: 2));
                    _firstScallController.reset();
                  }
                }
              });
              Future.delayed(Duration(milliseconds: 200),(){
                if (!_firstScallController.isAnimating || _firstScallController.isCompleted){
                  _firstScallController.forward();
                }
              });
              setState(() {
              });
            }
          }
        },
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: (){
              // showToast("错",position: ToastPosition.top);
              penMouseHoverTimer?.cancel();
              currentColor = defaultColor;
              listenerText = "";
              _firstScallController.reverse();
              penMouseHoverTimer = null;
              lastEnterHoverTimestamp = null;
              setState(() {
              });
            },
            onLongPress: (){
              showToast("longPress",position: ToastPosition.top);
              penMouseHoverTimer?.cancel();
              currentColor = defaultColor;
              listenerText = "";
              _firstScallController.reverse();
              penMouseHoverTimer = null;
              lastEnterHoverTimestamp = null;
              setState(() {
              });
            },
            onHover: (isHover){
              showToast("on hover");
            },
            onHighlightChanged: (isHighlight){
              showToast("on highlight");
            },
            onFocusChange: (isFocus){
              showToast("on focus");
            },
            child:Animate(
                controller: _firstScallController,
                onPlay: (controller){
                  if (controller.status == AnimationStatus.forward && penMouseHoverTimer == null){
                    // showToast("first play");
                    controller.reset();
                  }
                },
                effects: [
                  ShimmerEffect(duration: Duration(milliseconds: 600)),
                  ThenEffect(delay: Duration(milliseconds: 2000)),
                  ScaleEffect(begin: Offset(1.0, 1.0), end: Offset(2, 2), duration: Duration(milliseconds: 200),curve: Curves.easeOutBack)],
                child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    padding: EdgeInsets.only(top: 2),
                    child: MiniZhouYiGuaWidget(guaBinaryContent: cuoBinaryContent,guaName: cuoFullname,guaExtraName: '错'))

            ))
    );
  }

  // 八宫世卦
  Widget baGongShiGuaWidget(String fullname){
    var pureGuaShortname = eightGuaInfo["index"][fullname];
    List<dynamic> gongGuaList = eightGuaInfo["content"][pureGuaShortname];
    // print(json.encode(gongGuaList));

    var counter = 0;
    Iterable<Tuple4<String,String,String,List<int>>> allGuaList = gongGuaList.map((e){
      if (guaFullnameBinaryIndexDB[e["name"]] == null) {
        print(e["name"]);
      }
      var rawBinaryLis = guaFullnameBinaryIndexDB[e["name"]] as String;
      String binaryList = rawBinaryLis.split("").reversed.join("");

      String chuaSubtitle = "";
      switch (counter){
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
      return Tuple4<String,String,String,List<int>>(
          binaryList,
          e["name"],
          chuaSubtitle,
          List<int>.from(e["changes"].map((i) => i))
      );
    });
    var guaWidgetList = allGuaList.map((e) => Card(
        elevation: e.item2==fullname?2:0,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            color: e.item2==fullname?Color.fromRGBO(51, 102, 153, .1):Colors.transparent,
            child: TinyZhouYiGuaWidget(guaBinaryContent: e.item1,guaName: e.item2,guaExtraName:e.item3, height: 6,width: 48,yaoInterval: 3,changedYaoIndexList:e.item4))
    )).toList();
    // return Container(
    //   child: ListView(
    //     children: guaWidgetList,
    //   ),
    // );
    return Container(
      width: 512,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:guaWidgetList
        ),
      ),
    );
  }
  Widget zhouYiYao(bool yaoYinYang, double width, double height,int index){
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        // width: isSelected?scaleFactor * width:width,
        child:InkWell(
            onTap: (){
              if (selectedIndex == index){
                setState(() {
                  selectedIndex = -1;
                });
                return;
              }
              setState(() {
                selectedIndex = index;
              });
              showToast(
                "$index-$selectedIndex",
                duration: Duration(seconds: 2),
                position: ToastPosition.bottom,
                backgroundColor: Colors.black.withOpacity(0.8),
                radius: 3.0,
                textStyle: TextStyle(fontSize: 30.0),
              );
            },
            child: Container(
              height:double.infinity,
              width: double.infinity,
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
            )
        )
    );
    // return yao(yaoYinYang, width, height,index,1.2);
  }
  GlobalKey _toolTipKey = GlobalKey();
  List<GlobalKey> _TooltipKeyList = [];
  Widget jiaoShiYiLingWidget(String guaShortName){
    var gua_zhi_map = jiaoShiYiLin[guaShortName];
    List gua_zhi = gua_zhi_map.entries.toList();
    List<Widget> listView = [];
    for (int i = 0; i < gua_zhi.length; i++) {
      var guaName = gua_zhi[i].value['gua'];
      var content = gua_zhi[i].value['content'];
      var currentToolTipKey = GlobalKey();
      _TooltipKeyList.add(currentToolTipKey);

      listView.add(
        GlassContainer(
          height: 64,
          width: 48,
          opacity: 0.2,
          color: i == 0 ?Colors.lightBlue.withOpacity(0.4):Colors.lightBlue.withOpacity(0.2),
          blur: 4,
          borderRadius: BorderRadius.circular(8),
          shadowColor: Colors.white.withOpacity(0.2),
          // onTap: (){
          //   final dynamic _toolTip = currentToolTipKey.currentState;
          //   _toolTip.ensureTooltipVisible();
          // },
          child: Tooltip(
              key: currentToolTipKey,
              message: content,
              triggerMode: TooltipTriggerMode.tap,
              child: TinyZhouYiGuaWidget(guaBinaryContent: guaShortnameBinaryIndexDB[guaName],guaName: guaName,guaExtraName:null, height: 3,width: 24,yaoInterval: 2)),
        )
        );
    }

    return Container(
        height: 72,
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

  // 'true' is yang and 'false' is yin
  Widget sixYao(bool yaoYinYang, double width, double height,int index,{double scaleFactor = 1.2,double fontSize = 16,bool hiddenText = false,int changedIndex = -1}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hiddenText?Container():Container(
          child: AnimatedDefaultTextStyle(
            duration: _selectedAnimationDuration,
            style: TextStyle(
              fontSize: fontSize,
              color: selectedIndex == index ?Colors.black87:Colors.black54,
            ),
            child: Text(
              liuShou[index],
            ),
          ),
        ),
        yao(yaoYinYang, width, height,index,scaleFactor,changedIndex: changedIndex),
        hiddenText?Container():Container(
          child: AnimatedDefaultTextStyle(
            duration: _selectedAnimationDuration,
            style: TextStyle(
              fontSize: fontSize,
              color: selectedIndex == index ?Colors.black87:Colors.black54,
            ),
            child: Text(
              index == 5?liuQin[0] :liuQin[index],
            ),
          ),
        ),
      ],
    );
  }

  // 只绘制 阴阳爻,没有六爻中，六亲六兽世应等信息；以及梅花易数中变爻的信息
  Widget yao(bool yaoYinYang, double width, double height,int index,double scaleFactor,{int changedIndex = -1}) {
    Color mainColor = changedIndex == index ? Colors.red.shade800:Colors.black87;
    Color selectedMainColor = Colors.red.shade800;
    Color shadowColor = mainColor.withOpacity(0.5);
    Color selectedShadowColor = selectedMainColor.withOpacity(0.5);
    bool isSelected = selectedIndex == index;
    return AnimatedContainer(
      alignment: Alignment.center,
        duration: _selectedAnimationDuration,
        // margin: isSelected?const EdgeInsets.all(12):EdgeInsets.all(4),
        margin: isSelected?const EdgeInsets.all(6):EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        width: isSelected?scaleFactor * width:width,
      child:InkWell(
        onTap: (){
          if (selectedIndex == index){
            setState(() {
              selectedIndex = -1;
            });
            return;
          }
          setState(() {
            selectedIndex = index;
          });
          showToast(
            "$index-$selectedIndex",
            duration: Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 3.0,
            textStyle: TextStyle(fontSize: 30.0),
          );
        },
        child: yaoYinYang
            ?AnimatedContainer(
            duration: _selectedAnimationDuration,
            height:isSelected?scaleFactor * height:height,
            width: isSelected?scaleFactor * width:width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(56),
              color: isSelected? selectedMainColor: mainColor,
              boxShadow: [
                BoxShadow(
                  color: isSelected?selectedShadowColor:shadowColor,
                  spreadRadius: isSelected? 6: 1,
                  blurRadius: isSelected? 10:5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
        )
            :Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                  duration: _selectedAnimationDuration,
                  height:isSelected?scaleFactor * height:height,
                  width: isSelected?scaleFactor * (width-16) * 0.46:(width-16) * 0.46,
                  // width:  (width-16) * 0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: isSelected? selectedMainColor: mainColor,
                    boxShadow: [
                      BoxShadow(
                        color: isSelected? selectedShadowColor:shadowColor,
                        spreadRadius: isSelected? 6: 1,
                        blurRadius: isSelected? 10:5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  )
              ),
              // SizedBox(width:  (width-16) * 0.08,),
              AnimatedContainer(
                  duration: _selectedAnimationDuration,
                  height:isSelected?scaleFactor * height:height,
                  width: isSelected?scaleFactor * (width-16) * 0.46:(width-16) * 0.46,
                  // width:  (width-16) * 0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: isSelected? selectedMainColor: mainColor,
                    boxShadow: [
                      BoxShadow(
                        color: isSelected? selectedShadowColor:shadowColor,
                        spreadRadius: isSelected? 6: 1,
                        blurRadius: isSelected? 10:5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  )
              )
            ],
      )
      )
    );
  }

  void baiduSearch(String searchContent){
    launchUrl(Uri.parse("http://www.baidu.com/s?wd=$searchContent"));
  }
  void handianSearch(String searchContent){
    // launchUrl(Uri.parse("https://www.zdic.net/search/?sclb=zi&q=%E4%B9%BE"));
    launchUrl(Uri.parse("https://www.zdic.net/hans/$searchContent"));
  }
  AdaptiveTextSelectionToolbar contentSelected(BuildContext context,
      EditableTextState editableTextState) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;
    // editableTextState.currentTextEditingValue.selection;
    var selection = editableTextState.currentTextEditingValue.selection;
    int selectFromIndex = selection.baseOffset;
    int selectToIndex = selection.extentOffset;
    String selectedContent = content.substring(selectFromIndex,selectToIndex);
    buttonItems.insert(
        0,
        ContextMenuButtonItem(
          label: '🌐 搜索',
          onPressed: () {
            ContextMenuController.removeAny();
            baiduSearch(selectedContent);
            // _showDialog(context);
          },
        ));
    if (selectedContent.length == 1){
      buttonItems.insert(
          0,
          ContextMenuButtonItem(
            label: '🔍 字典',
            onPressed: () {
              ContextMenuController.removeAny();
              handianSearch(selectedContent);
              // _showDialog(context);
            },
          ));
    }
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    );
  }
}

enum GuaSizeType {
  small,
  normal,
  large,
}
