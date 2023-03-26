import 'package:flutter/material.dart';
import 'package:my_flutter/pages/gua_details_page.dart';
import 'package:my_flutter/pages/si_zhu_ba_zi/si_zhu_ba_zi_page.dart';
import 'package:my_flutter/pages/zhou_yi_gua_details_page.dart';
import 'package:my_flutter/pages/zhou_yi_gua_list.dart';
import 'package:my_flutter/pages/ziweidoushu/zi_wei_dou_shu_pan_page.dart';
import 'package:my_flutter/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            // maxWidth: 1200,
            // minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        initialRoute: Routes.zhouyi,
        onGenerateRoute: (RouteSettings settings) {
          return Routes.fadeThrough(settings, (context) {
            switch (settings.name) {
              case Routes.home:
                return const Scaffold(
                  body: Center(
                    child: Text("Home"),
                  ),
                );
              case Routes.post:
                return const Scaffold(
                  body: Center(
                    child: Text("post"),
                  ),);
              case Routes.zhouyi_details:
                Map<String,dynamic> args = {
                  "name": "屯",
                  "content": "屯：元，亨，利，贞，勿用，有攸往，利建侯。",
                  "tuan": {
                    "content": "《彖》曰：屯，刚柔始交而难生，动乎险中，大亨贞。雷雨之动满盈，天造草昧，宜建侯而不宁。",
                    "name": "屯·彖"
                  },
                  "xiang": {
                    "content": "《象》曰：云，雷，屯；君子以经纶。",
                    "name": "屯·象"
                  },
                  "yao_list": [
                    {
                      "name": "屯·初九",
                      "yao": "『初九』：磐桓；利居贞，利建侯。",
                      "yao_xiang": "《象》曰：虽磐桓，志行正也。以贵下贱，大得民也。"
                    },
                    {
                      "name": "屯·六二",
                      "yao": "『六二』：屯如邅如，乘马班如。匪寇婚媾，女子贞不字，十年乃字。",
                      "yao_xiang": "《象》曰：『六二』之难，乘刚也。十年乃字，反常也。"
                    },
                    {
                      "name": "屯·六三",
                      "yao": "『六三』：既鹿无虞，惟入于林中，君子几不如舍，往吝。",
                      "yao_xiang": "《象》曰：既鹿无虞，以纵禽也。君子舍之，往吝穷也。"
                    },
                    {
                      "name": "屯·六四",
                      "yao": "『六四』：乘马班如，求婚媾，无不利。",
                      "yao_xiang": "《象》曰：求而往，明也。"
                    },
                    {
                      "name": "屯·九五",
                      "yao": "『九五』：屯其膏，小贞吉，大贞凶。",
                      "yao_xiang": "《象》曰：屯其膏，施未光也。"
                    },
                    {
                      "name": "屯·上六",
                      "yao": "『上六』：乘马班如，泣血涟如。",
                      "yao_xiang": "《象》曰：泣血涟如，何可长也。"
                    }
                  ]
                };
                // return ZhouYiGuaDetailsPage(args);
                return ZhouYiGuaDetailsPage(settings.arguments as Map<String, dynamic>,);
              case Routes.zhouyi:
                return ZhouYiGuaListPage();
              case Routes.ziWeiDouShu_pan:
                return ZiWeiDouShuPanPage();
                case Routes.siZhuBaZi_pan:
                  return SiZhuBaZiPage();
              default:
                return const SizedBox.shrink();
            }
          });
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
  // This widget is the root of your application.
  @Deprecated("use build, it is Responsive")
  Widget build_default(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
