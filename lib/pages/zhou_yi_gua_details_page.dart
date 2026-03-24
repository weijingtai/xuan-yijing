
import 'dart:async';
import 'dart:convert';
import 'dart:ui' show ImageFilter;

import 'package:card_loading/card_loading.dart';
import "package:logger/logger.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:info_popup/info_popup.dart';
import 'package:my_flutter/widgets/tiny_zhou_yi_gua_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import '../databases/MyDatabase.dart';
import '../routes.dart';
import '../widgets/mini_zhou_yi_gua_widget.dart';
import '../widgets/small_zhou_yi_gua_widget.dart';
import '../widgets/zhou_yi_gua_widget.dart';

class ZhouYiGuaDetailsPage extends StatefulWidget {
  late ZhouYi zhouYi;
  double cardWidth;

  // late List<dynamic> yao_list;
  ZhouYiGuaDetailsPage(Map<String, dynamic> args, {Key? key,this.cardWidth = 256}) : super(key: key){
    zhouYi = args["zhouYi"];
  }

  @override
  State<ZhouYiGuaDetailsPage> createState() => _ZhouYiGuaDetailsPageState();
}

class _ZhouYiGuaDetailsPageState extends State<ZhouYiGuaDetailsPage> with TickerProviderStateMixin {

  Logger logger = Logger();

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

  ValueNotifier<Tuple2<ZhouyiZhuBooks,String>?> displayZhuNotifier = ValueNotifier(null);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 240, 1),
      body: Stack(
        children: [
          buildRealBody(),
          ValueListenableBuilder(
              valueListenable: displayZhuNotifier,
              builder: (ctx,displayZhu,child){
            if (displayZhu != null){
              return GestureDetector(
                onDoubleTap: (){
                  displayZhuNotifier.value = null;
                },
                child: AnimatedOpacity(
                  opacity: displayZhuNotifier.value == null ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildLargeCard(displayZhu.item1,displayZhu.item2),
                        ],
                      ),
                    ),
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
  AdaptiveLayout buildRealBody(){

    String binaryContent = widget.zhouYi.binary;

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
                      child: zhouYiGua(binaryContent,widget.zhouYi.name, GuaSizeType.large,widget.zhouYi.fullname),
                    ),
                    SliverToBoxAdapter(
                      child: zhuPart(),
                    ),
                  ]
              )
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('Body2 Medium'),
              builder: (_) => InkWell(
                onTap: (){
                  },
                child: Listener(
                  onPointerHover: (event){
                    // showToast("main hover",position: ToastPosition.bottom);
                  },
                  child:zhouYiGua(binaryContent,widget.zhouYi.name,GuaSizeType.large,widget.zhouYi.fullname),
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
                return zhuPart();
              }
          ),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
    );
  }

  Widget zhuPart() {
    return FutureBuilder(
      future: Future.wait([
        Get.find<MyDatabase>().findAllGuaZhu(widget.zhouYi.binary),
        Get.find<MyDatabase>().findAllYaoZhu(widget.zhouYi.binary),
        Get.find<MyDatabase>().findAllZhuBooks(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final guaZhuList = snapshot.data[0] as List<ZhouYiGuaZhu>;
          final guaYaoZhuList = snapshot.data[1] as List<ZhouYiYaoZhu>;
          final booksList = snapshot.data[2] as List<ZhouyiZhuBooks>;

          final mapper = <int, Tuple2<ZhouYiGuaZhu?, List<ZhouYiYaoZhu>>>{};
          final allSingeGuaZhu = <ZhouYiGuaZhu>[];

          for (final guaZhu in guaZhuList) {
            if (guaZhu.isSingle) {
              allSingeGuaZhu.add(guaZhu);
            } else {
              mapper[guaZhu.bookId] = Tuple2(guaZhu, []);
            }
          }

          for (final yaoZhu in guaYaoZhuList) {
            final tuple2 = mapper[yaoZhu.bookId];
            if (tuple2 == null) {
              logger.e("yaoZhu.bookId: ${yaoZhu.bookId} not found");
              mapper[yaoZhu.bookId] = Tuple2(null, <ZhouYiYaoZhu>[]);
            }
            mapper[yaoZhu.bookId]!.item2.add(yaoZhu);
          }

          final res = mapper.entries
              .map((entry) => MapEntry(
              booksList.firstWhere((book) => book.id == entry.key),
              entry.value))
              .toList()
            ..sort((a, b) => a.key.id.compareTo(b.key.id));

          return Container(
            color: Color.fromRGBO(242, 236, 222, 1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: res.map((entry) => eachZhuCard(entry.key, entry.value.item1, entry.value.item2)).toList(),
              ),
            ),
          );
        }

        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget eachZhuCard(ZhouyiZhuBooks book, ZhouYiGuaZhu? guaZhu, List<ZhouYiYaoZhu> yaoZhuList){
    return Container(
      height: widget.cardWidth,
      alignment: Alignment.center,
      // color: Colors.green.shade50,
        color: Color.fromRGBO(242, 236, 222, 1), // 缟色
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Container(
              height:24,
              alignment: Alignment.center,
              child: Text("（${book.bookage}·${book.bookauth}）《${book.bookname}》")
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 9,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                String? content;
                switch (index) {
                  case 0:
                    content = guaZhu?.guaZhu;
                    break;
                  case 1:
                    content = guaZhu?.tuanZhu;
                    break;
                  case 2:
                    content = guaZhu?.xiangZhu;
                    break;
                  default:
                    content = yaoZhuList[index - 3].yaoZhu;
                    break;
                }
                return InkWell(
                  onTap: () {
                    // showToast("tap");
                    yaoZhuScrollTo(index);
                  },
                  onDoubleTap: () {
                    // showToast("double tap");
                    popupYaoZhu(book, content!);
                  },
                  child: Card(
                    // color: Color.fromRGBO(224, 240, 233, 1), // 素色
                    child: Container(
                      width: widget.cardWidth,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 卦、彖、象的标题
                          Container(
                            height: 200,
                            width: widget.cardWidth,
                            alignment: Alignment.center,
                            child: Text(
                              "${["卦","彖","象","初","二","三","四","五","上"][index]}",
                              style: TextStyle(fontSize: 72, color: Colors.black12),
                            ),
                          ),
                          // 卦、彖、象、初、二、三、四、五、上的卡片内容
                          Container(
                            height: 200,
                            width: widget.cardWidth,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 4,right: 0,top: 8,bottom: 8),
                            child: content == null || content.isEmpty ? Container() : SelectableText.rich(
                              TextSpan(text: content),
                              contextMenuBuilder: content == null?null:(arg1,arg2) => contentSelected(arg1,arg2, content!),
                              onTap: (){
                                popupYaoZhu(book, content!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLargeCard(ZhouyiZhuBooks book,String content){
    // get current screen size
    // using min size of width or height
    double size = MediaQuery.of(context).size.shortestSide;
   return Container(
       width: size * 0.6,
       child:Card(
         elevation: 8,
         child: InkWell(
           // onTap: ()=>Navigator.pop(context),
           // onDoubleTap: ()=>Navigator.pop(context),
             child: Column(
                 children:[
                   SizedBox(height: 16,),
                   Text("（${book.bookage}·${book.bookauth}）《${book.bookname}》",style: TextStyle(fontSize: 18)),
                   Container(
                     width: MediaQuery.of(context).size.height * 0.6,
                     margin: EdgeInsets.symmetric(horizontal: 8),
                     // color: Colors.blue[(1+index) * 100],
                     padding: EdgeInsets.only(left: 16,right: 8,top: 16,bottom: 16),
                     // child: Text(["彖","象","初","二","三","四","五","上"][index]),
                     child:SelectableText.rich(
                       TextSpan(text: content,style: TextStyle(fontSize: 18)),
                       // onTap: ()=>Navigator.pop(context),
                       onSelectionChanged: (selection,cause){
                         int selectFromIndex = selection.baseOffset;
                         int selectToIndex = selection.extentOffset;
                         showToast("selection changed: ${content.substring(selectFromIndex,selectToIndex)}");
                       },
                       contextMenuBuilder: (arg1,arg2) =>contentSelected(arg1,arg2,content),),
                   ),
                 ]
             )
         ),
       )
   ).animate().scaleXY(duration: Duration(milliseconds: 800),curve: Curves.easeInOutCirc);
  }
  void popupYaoZhu(ZhouyiZhuBooks book, String content){
    displayZhuNotifier.value = Tuple2(book, content);
  }


  DateTime lastPenHoverAt = DateTime.now();
  Duration? lastEnterHoverTimestamp;

  String listenerText = "";
  Color currentColor = Colors.blue;
  Color defaultColor = Colors.blue;
  Color defaultPenHover = Colors.redAccent;
  Timer? penMouseHoverTimer;
  // guaBinaryContent should like "101010" with length 6,
  // and the first number is the bottom yao
  Widget zhouYiGua(String guaBinaryContent,String shortname,GuaSizeType size,String fullname) {
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
                    Hero(
                        tag: "gua_binary_${shortname}",
                        child: ZhouYiGuaWidget(guaBinaryContent: guaBinaryContent.split("").reversed.join(""),selectedIndexNotifier: _selectedYaoXiangIndex)
                    ),
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
    );
  }
  // 爻辞， 爻象
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
    _scrollController.animateTo(index *  (widget.cardWidth + 8) , duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    Vibration.vibrate(duration: 100);
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
              return Container(
                width: 64,
                height: 64,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        FutureBuilder(
          future: Get.find<MyDatabase>().getZhouYiByBinary(cuo),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _buildCuoZongFuZa(snapshot.data!,'错');
            }else{
              return Container(
                width: 64,
                height: 64,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        FutureBuilder(
          future: Get.find<MyDatabase>().getZhouYiByBinary(zong),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return _buildCuoZongFuZa(snapshot.data!,'综');
            }else{
              return Container(
                width: 64,
                height: 64,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )
        // _buildCuoZongFuZa(zongFullname,zong,'综'),
      ],
    );
  }

  Map<String,InfoPopupController?> infoPopupControllerMapper = {};

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
              // setState(() {
              // });
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


//  八宫世卦
  Widget baGongShiGuaWidget(String fullname){

    return FutureBuilder(
      future:Future.wait([
        DefaultAssetBundle.of(context).loadString("resources/db/eight_gong_gua_info.json"),
        DefaultAssetBundle.of(context).loadString("resources/db/gua_fullname_binary_index.json"),
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
        DefaultAssetBundle.of(context).loadString("resources/db/ba_gong_sixteen_change_info.json"),
        DefaultAssetBundle.of(context).loadString("resources/db/gua_fullname_binary_index.json"),
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

  List<GlobalKey> _TooltipKeyList = [];
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

  void baiduSearch(String searchContent){
    launchUrl(Uri.parse("http://www.baidu.com/s?wd=$searchContent"));
  }
  void handianSearch(String searchContent){
    launchUrl(Uri.parse("https://www.zdic.net/hans/$searchContent"));
  }
  AdaptiveTextSelectionToolbar contentSelected(BuildContext context,
      EditableTextState editableTextState,String content) {
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
