import 'dart:convert';
import 'dart:ui' show ImageFilter;

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:yijing/databases/MyDatabase.dart';
import 'package:yijing/pages/zhou_yi_gua_hit_details.dart';
import 'package:oktoast/oktoast.dart';

import '../models/ZhouYiTable.dart';
import '../databases/MyDatabase.dart';
import '../routes.dart';
import '../widgets/tiny_zhou_yi_gua_widget.dart';

class ZhouYiGuaListPage extends StatefulWidget {
  const ZhouYiGuaListPage({Key? key}) : super(key: key);

  @override
  State<ZhouYiGuaListPage> createState() => _ZhouYiGuaListPageState();
}

class _ZhouYiGuaListPageState extends State<ZhouYiGuaListPage> {
  final Logger logger = Logger();

  List<ZhouYi> _zhouYiAllGuaList = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _largeRightSideZhouYiNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> ben = "010001".split("").toList();
    List<String> top = ben.sublist(1, 4);
    List<String> bottom = ben.sublist(2, 5);
    List<String> res = top..addAll(bottom);
    // MyDatabase().listAllZhouYi().then((allGua){
    //   logger.i("total ${allGua.length} gua loaded");
    // });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text("周易"),
        leading: Container(),
      ),
      body: WillPopScope(
          onWillPop: () {
            if (_largeRightSideZhouYiNotifier.value != null) {
              _largeRightSideZhouYiNotifier.value = null;
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: FutureBuilder<List<ZhouYi>>(
              future: Get.find<MyDatabase>().listAllZhouYi(),
              builder: (ctx, data) {
                if (data.hasData) {
                  _zhouYiAllGuaList = data.data!;
                  logger.i("total ${_zhouYiAllGuaList.length} gua loaded");
                  return buildBodyByModelList(data.data!);
                }
                if (data.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
      // body: FutureBuilder(
      //     future: loadsAllGua(),
      //     builder: (ctx, data){
      //       if (data.hasData){
      //         return buildBody(data.data!);
      //       }
      //       if (data.hasError){
      //         return const Center(child: Text("Error"),);
      //       }
      //       return const Center(child: CircularProgressIndicator(),);
      //     }),
    );
  }

  List<Map<String, dynamic>> allGua = <Map<String, dynamic>>[];
  Map<String, dynamic> guaFullnameBinaryIndexDB = {};

  Map<String, dynamic> guaBinaryFullnameIndexDB = {};
  Map<String, dynamic> guaShortnameBinaryIndexDB = {};
  @deprecated
  Future<List<Map<String, dynamic>>> loadsAllGua() async {
    List<dynamic> allLoads = await Future.wait([
      DefaultAssetBundle.of(context).loadString("resources/db/all_gua_v1.json"),
      DefaultAssetBundle.of(context)
          .loadString("resources/db/gua_fullname_binary_index.json"),
      DefaultAssetBundle.of(context)
          .loadString("resources/db/gua_shortname_binary_index.json"),
      DefaultAssetBundle.of(context)
          .loadString("resources/db/gua_binary_fullname_index.json")
    ]);
    allGua = (jsonDecode(allLoads[0]) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    guaFullnameBinaryIndexDB = json.decode(allLoads[1]) as Map<String, dynamic>;
    guaShortnameBinaryIndexDB =
        json.decode(allLoads[2]) as Map<String, dynamic>;
    guaBinaryFullnameIndexDB = json.decode(allLoads[3]) as Map<String, dynamic>;

    return allGua;
  }

  ValueNotifier<ZhouYi?> _largeRightSideZhouYiNotifier = ValueNotifier(null);
  Widget buildBody(List<Map<String, dynamic>> allGua) {
    return AdaptiveLayout(
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
              key: const Key('Body2 Small'), builder: (_) => guaList()),
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('Body2 Medium'), builder: (_) => guaList()),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.large: SlotLayout.from(
              key: const Key('SecondaryBody2 large'),
              builder: (_) {
                return ValueListenableBuilder(
                    valueListenable: _largeRightSideZhouYiNotifier,
                    builder: (ctx, zhouYi, child) {
                      return zhouYi == null
                          ? child!
                          : ZhouYiGuaPart(
                              zhouYi: zhouYi,
                            );
                    },
                    child: const Text("data"));
                // return ZhouYiGuaPart(zhouYi: null,);

                return ListView(
                    children: List<String>.generate(81, (index) {
                  String three = index.toRadixString(3);
                  var res = three.split("").toList();
                  if (res.length < 4) {
                    res.insertAll(
                        0, List.generate(4 - res.length, (index) => "0"));
                    three = res.join("");
                  }
                  return three;
                })
                        .map((e) => Card(
                              child: InkWell(
                                onTap: () {
                                  showToast(5.toRadixString(3));
                                },
                                child: ListTile(
                                  leading: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(56),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ce(e)),
                                ),
                              ),
                            ))
                        .toList());
              }),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
    );
  }

  Widget buildBodyByModelList(List<ZhouYi> allGua) {
    return AdaptiveLayout(
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
              key: const Key('Body2 Small'),
              builder: (_) => buildOnlyLeftPart()),
          Breakpoints.medium: SlotLayout.from(
              key: const Key('Body2 Medium'),
              builder: (_) => buildOnlyLeftPart()),
          Breakpoints.large: SlotLayout.from(
              key: const Key('Body2 Large'),
              builder: (_) => guaListWithModel()),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.large: SlotLayout.from(
              key: const Key('SecondaryBody2 large'),
              builder: (_) {
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "易",
                        style: TextStyle(
                            fontSize: 256, color: Colors.grey.withOpacity(.2)),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: _largeRightSideZhouYiNotifier,
                        builder: (ctx, zhouYi, child) {
                          // Using AnimateSwitcher to animate the transition between
                          // the two widgets.
                          return AnimatedSwitcher(
                              duration: 800.ms,
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              transitionBuilder: (child, animation) =>
                                  SlideTransition(
                                    position: Tween<Offset>(
                                            begin: Offset(0, 1.2),
                                            end: Offset(0, 0))
                                        .animate(animation),
                                    child: child,
                                  ),
                              child: zhouYi == null
                                  ? child!
                                  : Container(
                                      key: Key('SecondaryBody ${zhouYi.gua}'),
                                      color: Color.fromRGBO(255, 251, 240, 1),
                                      child: ZhouYiGuaPart(
                                        zhouYi: zhouYi,
                                      )));
                          return zhouYi == null
                              ? child!
                              : ZhouYiGuaPart(
                                  zhouYi: zhouYi,
                                );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          key: const Key("empty"),
                          // child: Text("易",style: TextStyle(fontSize: 256,color: Colors.grey.withOpacity(.2)),),
                        ))
                  ],
                );
                return ValueListenableBuilder(
                    valueListenable: _largeRightSideZhouYiNotifier,
                    builder: (ctx, zhouYi, child) {
                      // Using AnimateSwitcher to animate the transition between
                      // the two widgets.
                      return AnimatedSwitcher(
                          duration: Duration(milliseconds: 2000),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          transitionBuilder: (child, animation) =>
                              SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(0, 1.2),
                                        end: Offset(0, 0))
                                    .animate(animation),
                                child: child,
                              ),
                          child: zhouYi == null
                              ? child!
                              : Container(
                                  key: Key('SecondaryBody ${zhouYi.gua}'),
                                  child: ZhouYiGuaPart(
                                    zhouYi: zhouYi,
                                  )));
                      return zhouYi == null
                          ? child!
                          : ZhouYiGuaPart(
                              zhouYi: zhouYi,
                            );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      key: const Key("empty"),
                      child: Text(
                        "易",
                        style: TextStyle(
                            fontSize: 256, color: Colors.grey.withOpacity(.2)),
                      ),
                    ));
                return ListView(
                    children: List<String>.generate(81, (index) {
                  String three = index.toRadixString(3);
                  var res = three.split("").toList();
                  if (res.length < 4) {
                    res.insertAll(
                        0, List.generate(4 - res.length, (index) => "0"));
                    three = res.join("");
                  }
                  return three;
                })
                        .map((e) => Card(
                              child: InkWell(
                                onTap: () {
                                  showToast(5.toRadixString(3));
                                },
                                child: ListTile(
                                  leading: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(56),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ce(e)),
                                ),
                              ),
                            ))
                        .toList());
              }),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
    );
  }

  Widget buildOnlyLeftPart() {
    return Stack(
      children: [
        guaListWithModel(),
        ValueListenableBuilder(
            valueListenable: _largeRightSideZhouYiNotifier,
            builder: (ctx, zhouYi, child) {
              return zhouYi == null ? Container() : child!;
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(),
              ),
            )),
        ValueListenableBuilder(
            valueListenable: _largeRightSideZhouYiNotifier,
            builder: (ctx, zhouYi, child) {
              // Using AnimateSwitcher to animate the transition between
              // the two widgets.
              return AnimatedSwitcher(
                  duration: 800.ms,
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0, 1.2), end: Offset(0, 0))
                            .animate(animation),
                        child: child,
                      ),
                  child: zhouYi == null
                      ? child!
                      : Container(
                          key: Key('SecondaryBody ${zhouYi.gua}'),
                          margin: EdgeInsets.only(top: 128),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 251, 240, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: ZhouYiGuaPart(
                            zhouYi: zhouYi,
                          )));
              return zhouYi == null
                  ? child!
                  : ZhouYiGuaPart(
                      zhouYi: zhouYi,
                    );
            },
            child: Container(
              alignment: Alignment.center,
              key: const Key("empty"),
              // child: Text("易",style: TextStyle(fontSize: 256,color: Colors.grey.withOpacity(.2)),),
            ))
      ],
    );
  }

  Widget guaListWithModel() {
    return ListView(
        children: _zhouYiAllGuaList
            .map((e) => Card(
                  child: InkWell(
                    onDoubleTap: () {
                      Navigator.pushNamed(context, Routes.zhouyi_details,
                          arguments: {'zhouYi': e});
                    },
                    onTap: () {
                      if (_largeRightSideZhouYiNotifier.value != null &&
                          _largeRightSideZhouYiNotifier.value!.name == e.name) {
                        _largeRightSideZhouYiNotifier.value = null;
                      } else {
                        _largeRightSideZhouYiNotifier.value = e;
                      }
                    },
                    child: Container(
                      // color: Color.fromRGBO(238, 222, 176, 1),
                      color: Color.fromRGBO(255, 251, 240, .1),
                      child: ListTile(
                        leading: Hero(
                          tag: "gua_binary_${e.name}",
                          child: Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(209, 217, 224, 1),
                              color: Color.fromRGBO(242, 236, 222, 4),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TinyZhouYiGuaWidget(
                              guaBinaryContent:
                                  e.binary.split("").reversed.join(""),
                              guaName: "",
                              height: 4,
                              width: 30,
                              yaoInterval: 1,
                              guaInterval: 1,
                              guaExtraName: '',
                              displayYinYang: true,
                            ),
                          ),
                        ),
                        title: Container(
                          child: Text((e.name as String)),
                        ),
                        subtitle: Container(
                          child: Text((e.gua as String).split("：")[1]),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList());
  }

  Widget guaList() {
    return ListView(
        children: allGua
            .map((e) => Card(
                  child: InkWell(
                    onTap: () {
                      // showToast(e['name']);
                      Navigator.pushNamed(context, Routes.zhouyi_details,
                          arguments: {
                            'name': e['name'],
                            'content': e['content'],
                            'tuan': e['tuan'],
                            'xiang': e['xiang'],
                            'yao_list': e['yao_list'],
                          });
                    },
                    child: ListTile(
                      leading: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TinyZhouYiGuaWidget(
                          guaBinaryContent:
                              (guaShortnameBinaryIndexDB[e['name']] as String)
                                  .split("")
                                  .reversed
                                  .join(""),
                          // guaBinaryContent: guaShortnameBinaryIndexDB[e['name']],
                          guaName: "",
                          height: 4,
                          width: 30,
                          yaoInterval: 1,
                          guaInterval: 1, guaExtraName: '',
                        ),
                      ),
                      title: Container(
                        child: Text((e['name'] as String)),
                      ),
                      subtitle: Container(
                        child: Text((e['content'] as String).split("：")[1]),
                      ),
                    ),
                  ),
                ))
            .toList());
  }

  Widget ce(String content) {
    List<String> yaoList = content.split("");
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ceYao(yaoList[0]),
          SizedBox(
            height: 3,
          ),
          ceYao(yaoList[1]),
          SizedBox(
            height: 3,
          ),
          ceYao(yaoList[2]),
          SizedBox(
            height: 3,
          ),
          ceYao(yaoList[3]),
        ],
      ),
    );
  }

  Widget ceYao(String yao) {
    if (yao == "0") {
      return Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      );
    } else if (yao == "1") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 14,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width: 14,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width: 8,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width: 8,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
