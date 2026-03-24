import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:yijing/widgets/tiny_zhou_yi_gua_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/mini_zhou_yi_gua_widget.dart';
import '../widgets/small_zhou_yi_gua_widget.dart';
import '../widgets/zhou_yi_gua_widget.dart';

class GuaDetailsPage extends StatefulWidget {
  const GuaDetailsPage({Key? key}) : super(key: key);

  @override
  State<GuaDetailsPage> createState() => _GuaDetailsPageState();
}

class _GuaDetailsPageState extends State<GuaDetailsPage>
    with TickerProviderStateMixin {
  final Duration _selectedAnimationDuration = const Duration(milliseconds: 300);
  final List<String> liuShou = ["青龙", "白虎", "朱雀", "玄武", "勾陈", "螣蛇"];
  final List<String> liuQin = ["父母", "子孙", "兄弟", "妻财", "官鬼"];

  late AnimationController _firstScallController;
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
    super.dispose();
  }

  final String content =
      "梅花易数可以产生声音、方位、时间、动静、地理、天时、人物、颜色、动植物等自然界或人类社会中的一切感知的事物异相，作为预测其发展趋势的方法。从而可洞悉其先机达到知己知彼百战百胜的效果。"
      "梅花易数之由来，相传为麻衣道人、陈希夷等一脉绵延传下之秘法，后为北宋邵康节先生常用的心易神数。此数经邵先生传下后，也使易学在占筮领域上，更有其重大的实用价值，也由邵康节后，才改名为梅花易数。"
      "其名称的来源，相传有一天，邵康节先生进入梅花园赏花时，偶然见两只麻雀在枝头上争吵，后又见此二雀忽然争枝坠地，邵先生看到此种现象，即运用其心经易数，认为不动不占，不因事不占，今见二雀无故争枝坠地，怪哉！因觉有事而占之，断曰：明日当会有一邻女来攀折梅花，园丁不知而逐之，邻女惊恐自梅树跌下，伤到大腿。事后果然应验。"
      "后之学者因认为此卦例特殊，竟能断出与卦题不相干之事情来，为别种占法所不及，才将此种断法命名为“梅花易数”。";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    final List<Widget> children = <Widget>[
      for (int i = 0; i < 10; i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 201, 197),
            height: 400,
          ),
        )
    ];
    final List<Widget> children2 = <Widget>[
      for (int i = 0; i < 10; i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.lightBlueAccent,
            height: 400,
          ),
        )
    ];

    bool hiddenText = true;
    double firstChildWidth = 186; // 512
    double guaHeight = 140; // 180, 156
    double yaoChildWidth = 180; // 240, 180
    double yaoChildHeight = 28; // 32, 28
    double yaoFontSize = 14; // 16, 14
    double sanYaoInterval = 0; // 8,6,0
    double guaNameInterval = 12; // 16, 12
    return Scaffold(
      body: AdaptiveLayout(
        // Body switches between a ListView and a GridView from small to medium
        // breakpoints and onwards.
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
                key: const Key('Body2 Small'),
                builder: (_) => CustomScrollView(slivers: [
                      SliverList(delegate: SliverChildListDelegate([]))
                    ])),
            Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('Body2 Medium'),
                builder: (_) => InkWell(
                      onTap: () {
                        if (selectedIndex != -1) {
                          setState(() {
                            selectedIndex = -1;
                          });
                        }
                      },
                      child: Listener(
                        onPointerHover: (event) {
                          showToast("main hover",
                              position: ToastPosition.bottom);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                zhouYiGua(
                                    "010101", "火水未济", "本", GuaSizeType.large),
                              ],
                            )),
                      ),
                    )),
          },
        ),
        secondaryBody: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.large: SlotLayout.from(
                key: const Key('SecondaryBody2 large'),
                builder: (_) => Container(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              8,
                              (index) => Container(
                                  height: 256,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 24,
                                        alignment: Alignment.center,
                                        child: Text("Book Name"),
                                      ),
                                      Container(
                                          color: Colors.green[index * 100],
                                          height: 256 - 24,
                                          child: ListView.builder(
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                showToast("tap");
                                              },
                                              child: Card(
                                                  child: Container(
                                                height: 128,
                                                width: 256,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                // color: Colors.blue[(1+index) * 100],
                                                padding: EdgeInsets.only(
                                                    left: 4,
                                                    right: 0,
                                                    top: 8,
                                                    bottom: 4),
                                                // child: Text(["象","彖","初","二","三","四","五","上"][index]),
                                                child: SelectableText.rich(
                                                    TextSpan(text: content),
                                                    contextMenuBuilder:
                                                        contentSelected,
                                                    onTap: () {
                                                  showGeneralDialog(
                                                    context: context,
                                                    barrierColor: Colors.black12
                                                        .withOpacity(
                                                            0.6), // Background color
                                                    barrierDismissible: true,
                                                    barrierLabel: 'Dialog',
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 400),
                                                    pageBuilder: (_, __, ___) {
                                                      return Dialog(
                                                          child: InkWell(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          // color: Colors.blue[(1+index) * 100],
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4,
                                                                  right: 0,
                                                                  top: 8,
                                                                  bottom: 4),
                                                          // child: Text(["象","彖","初","二","三","四","五","上"][index]),
                                                          child: SelectableText
                                                              .rich(
                                                            TextSpan(
                                                                text: content),
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            onSelectionChanged:
                                                                (selection,
                                                                    cause) {
                                                              int selectFromIndex =
                                                                  selection
                                                                      .baseOffset;
                                                              int selectToIndex =
                                                                  selection
                                                                      .extentOffset;
                                                              showToast(
                                                                  "selection changed: ${content.substring(selectFromIndex, selectToIndex)}");
                                                            },
                                                            contextMenuBuilder:
                                                                contentSelected,
                                                          ),
                                                        ),
                                                      ));
                                                    },
                                                  );
                                                }),
                                              )),
                                            ),
                                            itemCount: [
                                              "象",
                                              "彖",
                                              "初",
                                              "二",
                                              "三",
                                              "四",
                                              "五",
                                              "上"
                                            ].length,
                                            scrollDirection: Axis.horizontal,
                                          ))
                                    ],
                                  )),
                            ))))),
            Breakpoints.largeDesktop: SlotLayout.from(
                key: const Key('SecondaryBody2 LargeDesktop'),
                builder: (_) => Container(
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                          Container(
                            color: Colors.green[100],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Container(
                            color: Colors.green[200],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Container(
                            color: Colors.green[300],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Container(
                            color: Colors.green[400],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Container(
                            color: Colors.green[500],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Container(
                            color: Colors.green[600],
                            margin: EdgeInsets.all(8),
                            height: 256,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Container(
                                height: 128,
                                width: 256,
                                margin: EdgeInsets.all(8),
                                color: Colors.blue[(1 + index) * 100],
                                child: Text([
                                  "象",
                                  "彖",
                                  "初",
                                  "二",
                                  "三",
                                  "四",
                                  "五",
                                  "上"
                                ][index]),
                              ),
                              itemCount: [
                                "象",
                                "彖",
                                "初",
                                "二",
                                "三",
                                "四",
                                "五",
                                "上"
                              ].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ])))),
            // Breakpoints.largeDesktop: SlotLayout.from(
            //   key: const Key('SecondaryBody2 LargeDesktop'),
            //   builder: (_) =>Row(
            //     children: [
            //       Container(
            //         color: Colors.green,
            //         alignment: Alignment.center,
            //         padding: EdgeInsets.symmetric(horizontal: 8),
            //         child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: ["象","彖","初","二","三","四","五","上"].map((e) => Container(
            //               margin: EdgeInsets.symmetric(vertical: 8),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(4),
            //               ),
            //               width: 32,
            //               height: 32,
            //               alignment: Alignment.center,
            //               child: Text(e,style: TextStyle(fontSize: 14),),
            //             )).toList()
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.blue,
            //           child: ListView.builder(
            //             itemCount: children2.length,
            //             itemBuilder: (BuildContext context, int index) => children2[index],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.red,
            //           child: ListView.builder(
            //             itemCount: children2.length,
            //             itemBuilder: (BuildContext context, int index) => children2[index],
            //           ),
            //         ),
            //       ),
            //     ],
            //   )
            // ),
          },
        ),
        // BottomNavigation is only active in small views defined as under 600 dp
        // width.
      ),
    );
    return AdaptiveLayout(
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (_) => ListView.builder(
              itemCount: children.length,
              itemBuilder: (BuildContext context, int index) => children[index],
            ),
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_) =>
                GridView.count(crossAxisCount: 2, children: children),
          )
        },
      ),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('SecondaryBody Small'),
            builder: (_) => ListView.builder(
              itemCount: children2.length,
              itemBuilder: (BuildContext context, int index) =>
                  children2[index],
            ),
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('SecondaryBody Medium'),
            builder: (_) =>
                GridView.count(crossAxisCount: 2, children: children2),
          )
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.dCol
    );
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
  Widget zhouYiGua(String guaBinaryContent, String guaName, String guaType,
      GuaSizeType size) {
    List<int> guaBinaryIter =
        guaBinaryContent.split("").map((e) => int.parse(e)).toList();
    double firstChildWidth = 200; // 512
    double guaHeight = 140; // 180, 156
    double yaoChildWidth = 180; // 240, 180
    double yaoChildHeight = 28; // 32, 28
    double guaNameInterval = 12; // 16, 12

    List<Widget> yaoWidgetList = guaBinaryIter
        .asMap()
        .entries
        .map((entry) => zhouYiYao(
            entry.value == 1, yaoChildWidth, yaoChildHeight, entry.key))
        .toList();
    final reversedYaoWidgetList = yaoWidgetList.reversed;
    bool isShimmered = false;
    return Container(
      alignment: Alignment.center,
      height: 720,
      width: 512,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onHover: (event) {
              showToast("gua hover");
              listenerText = "hover $lastPenHoverAt";
              currentColor = defaultPenHover;
              lastPenHoverAt = DateTime.now();
              Timer.periodic(Duration(seconds: 3), (timer) {
                if (lastPenHoverAt
                    .add(Duration(seconds: 3))
                    .isBefore(DateTime.now())) {
                  showToast("timer hover", duration: Duration(seconds: 10));
                  timer.cancel();
                  currentColor = defaultColor;
                  listenerText = "";
                  setState(() {});
                }
              });
              setState(() {});
            },
            onEnter: (event) {
              showToast("gua enter");
            },
            onExit: (event) {
              showToast("gua exit");
            },
            child: InkWell(
              onTap: () {
                showToast("gua click");
                // launchUrl(Uri.parse("http://www.baidu.com/s?wd=你好"));
                launchUrl(Uri.parse("firefox://"));
              },
              child: Container(
                  width: 100,
                  height: 100,
                  color: currentColor,
                  margin: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.center,
                  child: Text(listenerText)),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              color: Colors.blue,
              child: ZhouYiGuaWidget(
                guaBinaryContent: guaBinaryContent,
                fullGuaName: guaName,
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                  onHover: (event) {
                    if (lastEnterHoverTimestamp == null) {
                      showToast("start gua hover");
                      lastEnterHoverTimestamp = event.timeStamp;
                    } else {
                      lastPenHoverAt = DateTime.now();
                      var hoverOnMillisCounter =
                          event.timeStamp.inMilliseconds -
                              lastEnterHoverTimestamp!.inMilliseconds;
                      if (hoverOnMillisCounter >= 1000) {
                        listenerText =
                            "hover $lastPenHoverAt ${_firstScallController.status.name}";
                        if (penMouseHoverTimer != null) {
                          showToast("already started.",
                              position: ToastPosition.top);
                          return;
                        }
                        showToast("gua hover 3s, start scale up");
                        currentColor = defaultPenHover;
                        // forward() 必须在 penMousHoverTimer 赋值后 调用，
                        // 由于 flutter_animate 框架的原因，forward() 会自动调用forward()，不会等待手动 animationController.forward()
                        // 所以 为了防止UI在第一帧就显示被放大结果，所以判断 '_firstScallController.status == AnimationStatus.forward && penMouseHoverTimer == null'
                        // 为true时 调用_firstScallController.reset()，组织 flutter_animate 的自动调用forward()
                        penMouseHoverTimer ??= Timer.periodic(
                            Duration(milliseconds: 500), (timer) {
                          var now = DateTime.now();
                          if (lastPenHoverAt
                              .add(Duration(seconds: 2))
                              .isBefore(now)) {
                            timer.cancel();
                            currentColor = defaultColor;
                            listenerText = "";
                            penMouseHoverTimer = null;
                            lastEnterHoverTimestamp = null;
                            if (_firstScallController.isCompleted) {
                              _firstScallController.reverse();
                              showToast("timer hover left",
                                  duration: Duration(seconds: 2));
                            }
                          } else if (lastPenHoverAt
                              .add(Duration(seconds: 1))
                              .isBefore(now)) {
                            if (_firstScallController.isAnimating) {
                              showToast(
                                  "timer hover left before scale up ${lastPenHoverAt.add(Duration(seconds: 2)).isAfter(now)}",
                                  duration: Duration(seconds: 2));
                              _firstScallController.reset();
                            }
                          }
                        });
                        Future.delayed(Duration(milliseconds: 200), () {
                          if (!_firstScallController.isAnimating ||
                              _firstScallController.isCompleted) {
                            _firstScallController.forward();
                          }
                        });
                        setState(() {});
                      }
                    }
                  },
                  child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        showToast("错", position: ToastPosition.top);
                        penMouseHoverTimer?.cancel();
                        currentColor = defaultColor;
                        listenerText = "";
                        _firstScallController.reverse();
                        penMouseHoverTimer = null;
                        lastEnterHoverTimestamp = null;
                        setState(() {});
                      },
                      onLongPress: () {
                        showToast("longPress", position: ToastPosition.top);
                        penMouseHoverTimer?.cancel();
                        currentColor = defaultColor;
                        listenerText = "";
                        _firstScallController.reverse();
                        penMouseHoverTimer = null;
                        lastEnterHoverTimestamp = null;
                        setState(() {});
                      },
                      onHover: (isHover) {
                        showToast("on hover");
                      },
                      onHighlightChanged: (isHighlight) {
                        showToast("on highlight");
                      },
                      onFocusChange: (isFocus) {
                        showToast("on focus");
                      },
                      child: Animate(
                          controller: _firstScallController,
                          onPlay: (controller) {
                            if (controller.status == AnimationStatus.forward &&
                                penMouseHoverTimer == null) {
                              // showToast("first play");
                              controller.reset();
                            }
                          },
                          // effects: isShimmered?[ScaleEffect(begin: Offset(1.0, 1.0), end: Offset(2, 2), duration: Duration(milliseconds: 200),curve: Curves.easeOutBack)]
                          //     :[ShimmerEffect(duration: Duration(milliseconds: 600))],
                          effects: [
                            ShimmerEffect(
                                duration: Duration(milliseconds: 600)),
                            ThenEffect(delay: Duration(milliseconds: 2000)),
                            ScaleEffect(
                                begin: Offset(1.0, 1.0),
                                end: Offset(2, 2),
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeOutBack)
                          ],
                          child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: EdgeInsets.only(top: 2),
                              child: MiniZhouYiGuaWidget(
                                  guaBinaryContent: '101010',
                                  guaName: '水火既济',
                                  guaExtraName: '错'))))
/*                  child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: EdgeInsets.only(top: 2),
                      child: TinyZhouYiGuaWidget(guaBinaryContent: '101010',guaName: '水火既济',guaExtraName: '错', height: 3,width: 24,yaoInterval: 2,))

                ).animate(controller: _firstScallController,)
                    .scale(begin: Offset(1.0, 1.0), end: Offset(2, 2), duration: Duration(milliseconds: 200)),*/
                  ),
              Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: EdgeInsets.only(top: 2),
                  child: MiniZhouYiGuaWidget(
                      guaBinaryContent: '101010',
                      guaName: '水火既济',
                      guaExtraName: '综')),
              Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: EdgeInsets.only(top: 2),
                  child: MiniZhouYiGuaWidget(
                      guaBinaryContent: '101010',
                      guaName: '水火既济',
                      guaExtraName: '互'))
            ],
          ),
          Container(
              height: 80,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Tuple4<String, String, String, List<int>>(
                        '101101', '离为火', '离宫纯卦', []),
                    Tuple4<String, String, String, List<int>>(
                        '001101', '火山旅', '初爻变', [0]),
                    Tuple4<String, String, String, List<int>>(
                        '011101', '火风鼎', '二爻变', [0, 1]),
                    Tuple4<String, String, String, List<int>>(
                        '010101', '火水未济', '三爻变', [0, 1, 2]),
                    Tuple4<String, String, String, List<int>>(
                        '010001', '山水蒙', '四爻变', [0, 1, 2, 3]),
                    Tuple4<String, String, String, List<int>>(
                        '010011', '风水涣', '五爻变', [0, 1, 2, 3, 4]),
                    Tuple4<String, String, String, List<int>>(
                        '010111', '天水讼', '游魂卦', [0, 1, 2, 4]),
                    Tuple4<String, String, String, List<int>>(
                        '101111', '天火同人', '归魂卦', [4])
                  ]
                      .map((e) => Card(
                          elevation: e.item1 == guaBinaryContent ? 2 : 0,
                          child: Container(
                              color: e.item1 == guaBinaryContent
                                  ? Color.fromRGBO(51, 102, 153, .1)
                                  : Colors.transparent,
                              child: TinyZhouYiGuaWidget(
                                  guaBinaryContent: e.item1,
                                  guaName: e.item2,
                                  guaExtraName: e.item3,
                                  height: 3,
                                  width: 24,
                                  yaoInterval: 2,
                                  changedYaoIndexList: e.item4))))
                      .toList())),
          Container(
              height: 80,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                    Tuple2<String, String>('010101', '火水未济'),
                    Tuple2<String, String>('101101', '离为火'),
                    Tuple2<String, String>('001101', '火山旅'),
                    Tuple2<String, String>('011101', '火风鼎'),
                    Tuple2<String, String>('010001', '山水蒙'),
                    Tuple2<String, String>('010011', '风水涣'),
                    Tuple2<String, String>('010111', '天水讼'),
                    Tuple2<String, String>('101111', '天火同人'),
                  ]
                      .map((e) => Card(
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TinyZhouYiGuaWidget(
                                  guaBinaryContent: e.item1,
                                  guaName: e.item2,
                                  guaExtraName: null,
                                  height: 3,
                                  width: 24,
                                  yaoInterval: 2))))
                      .toList()))
        ],
      ),
    );
  }

  Widget zhouYiYao(bool yaoYinYang, double width, double height, int index) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        // width: isSelected?scaleFactor * width:width,
        child: InkWell(
            onTap: () {
              if (selectedIndex == index) {
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
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: yaoYinYang ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(64),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            )));
    // return yao(yaoYinYang, width, height,index,1.2);
  }

  // 'true' is yang and 'false' is yin
  Widget sixYao(bool yaoYinYang, double width, double height, int index,
      {double scaleFactor = 1.2,
      double fontSize = 16,
      bool hiddenText = false,
      int changedIndex = -1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hiddenText
            ? Container()
            : Container(
                child: AnimatedDefaultTextStyle(
                  duration: _selectedAnimationDuration,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: selectedIndex == index
                        ? Colors.black87
                        : Colors.black54,
                  ),
                  child: Text(
                    liuShou[index],
                  ),
                ),
              ),
        yao(yaoYinYang, width, height, index, scaleFactor,
            changedIndex: changedIndex),
        hiddenText
            ? Container()
            : Container(
                child: AnimatedDefaultTextStyle(
                  duration: _selectedAnimationDuration,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: selectedIndex == index
                        ? Colors.black87
                        : Colors.black54,
                  ),
                  child: Text(
                    index == 5 ? liuQin[0] : liuQin[index],
                  ),
                ),
              ),
      ],
    );
  }

  // 只绘制 阴阳爻,没有六爻中，六亲六兽世应等信息；以及梅花易数中变爻的信息
  Widget yao(bool yaoYinYang, double width, double height, int index,
      double scaleFactor,
      {int changedIndex = -1}) {
    Color mainColor =
        changedIndex == index ? Colors.red.shade800 : Colors.black87;
    Color selectedMainColor = Colors.red.shade800;
    Color shadowColor = mainColor.withOpacity(0.5);
    Color selectedShadowColor = selectedMainColor.withOpacity(0.5);
    bool isSelected = selectedIndex == index;
    return AnimatedContainer(
        alignment: Alignment.center,
        duration: _selectedAnimationDuration,
        // margin: isSelected?const EdgeInsets.all(12):EdgeInsets.all(4),
        margin: isSelected ? const EdgeInsets.all(6) : EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        width: isSelected ? scaleFactor * width : width,
        child: InkWell(
            onTap: () {
              if (selectedIndex == index) {
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
                ? AnimatedContainer(
                    duration: _selectedAnimationDuration,
                    height: isSelected ? scaleFactor * height : height,
                    width: isSelected ? scaleFactor * width : width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      color: isSelected ? selectedMainColor : mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: isSelected ? selectedShadowColor : shadowColor,
                          spreadRadius: isSelected ? 6 : 1,
                          blurRadius: isSelected ? 10 : 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                          duration: _selectedAnimationDuration,
                          height: isSelected ? scaleFactor * height : height,
                          width: isSelected
                              ? scaleFactor * (width - 16) * 0.46
                              : (width - 16) * 0.46,
                          // width:  (width-16) * 0.46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            color: isSelected ? selectedMainColor : mainColor,
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? selectedShadowColor
                                    : shadowColor,
                                spreadRadius: isSelected ? 6 : 1,
                                blurRadius: isSelected ? 10 : 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          )),
                      // SizedBox(width:  (width-16) * 0.08,),
                      AnimatedContainer(
                          duration: _selectedAnimationDuration,
                          height: isSelected ? scaleFactor * height : height,
                          width: isSelected
                              ? scaleFactor * (width - 16) * 0.46
                              : (width - 16) * 0.46,
                          // width:  (width-16) * 0.46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            color: isSelected ? selectedMainColor : mainColor,
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? selectedShadowColor
                                    : shadowColor,
                                spreadRadius: isSelected ? 6 : 1,
                                blurRadius: isSelected ? 10 : 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ))
                    ],
                  )));
  }

  void baiduSearch(String searchContent) {
    launchUrl(Uri.parse("http://www.baidu.com/s?wd=$searchContent"));
  }

  void handianSearch(String searchContent) {
    // launchUrl(Uri.parse("https://www.zdic.net/search/?sclb=zi&q=%E4%B9%BE"));
    launchUrl(Uri.parse("https://www.zdic.net/hans/$searchContent"));
  }

  AdaptiveTextSelectionToolbar contentSelected(
      BuildContext context, EditableTextState editableTextState) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;
    // editableTextState.currentTextEditingValue.selection;
    var selection = editableTextState.currentTextEditingValue.selection;
    int selectFromIndex = selection.baseOffset;
    int selectToIndex = selection.extentOffset;
    String selectedContent = content.substring(selectFromIndex, selectToIndex);
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
    if (selectedContent.length == 1) {
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
