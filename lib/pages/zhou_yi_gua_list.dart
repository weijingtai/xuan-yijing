import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:oktoast/oktoast.dart';

import '../routes.dart';
import '../widgets/tiny_zhou_yi_gua_widget.dart';

class ZhouYiGuaListPage extends StatefulWidget {
  const ZhouYiGuaListPage({Key? key}) : super(key: key);

  @override
  State<ZhouYiGuaListPage> createState() => _ZhouYiGuaListPageState();
}

class _ZhouYiGuaListPageState extends State<ZhouYiGuaListPage> {

  @override
  Widget build(BuildContext context) {
    List<String> ben = "010001".split("").toList();
    List<String> top = ben.sublist(1, 4);
    List<String> bottom = ben.sublist(2, 5);
    List<String> res = top..addAll(bottom);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text("周易"),
        leading: Container(),
      ),
      body: FutureBuilder(
  future: loadsAllGua(),
          builder: (ctx, data){
            if (data.hasData){
              return buildBody(data.data!);
            }
            if (data.hasError){
              return const Center(child: Text("Error"),);
            }
            return const Center(child: CircularProgressIndicator(),);
          }),
    );
  }
  List<Map<String, dynamic>> allGua = <Map<String,dynamic>>[];
  Map<String,dynamic> guaFullnameBinaryIndexDB = {};

  Map<String,dynamic> guaBinaryFullnameIndexDB = {};
  Map<String,dynamic> guaShortnameBinaryIndexDB = {};
  Future<List<Map<String, dynamic>>> loadsAllGua() async {

    List<dynamic> allLoads = await Future.wait([
      DefaultAssetBundle.of(context).loadString("resources/db/all_gua_v1.json"),
    DefaultAssetBundle.of(context).loadString("resources/db/gua_fullname_binary_index.json"),
    DefaultAssetBundle.of(context).loadString("resources/db/gua_shortname_binary_index.json"),

      DefaultAssetBundle.of(context).loadString("resources/db/gua_binary_fullname_index.json")
    ]);
    allGua = (jsonDecode(allLoads[0]) as List).map((e) => e as Map<String, dynamic>).toList();

    guaFullnameBinaryIndexDB = json.decode(allLoads[1]) as Map<String,dynamic>;
    guaShortnameBinaryIndexDB = json.decode(allLoads[2]) as Map<String,dynamic>;
    guaBinaryFullnameIndexDB = json.decode(allLoads[3]) as Map<String,dynamic>;

    return allGua;
  }
  Widget buildBody(List<Map<String, dynamic>> allGua){
    return AdaptiveLayout(
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
              key: const Key('Body2 Small'),
              builder: (_) => guaList()
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('Body2 Medium'),
              builder: (_) => guaList()
          ),
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.large: SlotLayout.from(
              key: const Key('SecondaryBody2 large'),
              builder: (_) {

                return ListView(
                    children: List<String>.generate(81, (index){
                      String three = index.toRadixString(3);
                      var res = three.split("").toList();
                      if (res.length < 4){
                        res.insertAll(0, List.generate(4-res.length, (index) => "0"));
                        three = res.join("");
                      }
                      return three;
                    }).map((e) => Card(
                      child: InkWell(
                        onTap: (){
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
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ce(e)
                          ),
                        ),
                      ),
                    )).toList()
                );
              }
          ),
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
    );
  }
  Widget guaList(){
    return ListView(
        children: allGua.map((e) => Card(
          child: InkWell(
            onTap: (){
              // showToast(e['name']);
              Navigator.pushNamed(context, Routes.zhouyi_details, arguments: {
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
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TinyZhouYiGuaWidget(
                  guaBinaryContent: (guaShortnameBinaryIndexDB[e['name']] as String).split("").reversed.join(""),
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
        )).toList()
    );
  }




  Widget ce(String content){
    List<String> yaoList = content.split("");
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ceYao(yaoList[0]),
          SizedBox(height: 3,),
          ceYao(yaoList[1]),
          SizedBox(height: 3,),
          ceYao(yaoList[2]),
          SizedBox(height: 3,),
          ceYao(yaoList[3]),
        ],
      ),
    );
  }
  Widget ceYao(String yao){
    if (yao=="0"){
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
    }else if (yao == "1"){
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
            SizedBox(width: 4,),
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
    }else{
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
          SizedBox(width: 4,),
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
          SizedBox(width: 4,),
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
