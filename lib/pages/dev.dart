
import 'package:flutter/material.dart';

class Dev extends StatefulWidget {
  const Dev({Key? key}) : super(key: key);

  @override
  State<Dev> createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Dev 页面\n\n(flutter_neumorphic_plus 将在迁移到\nSDK 3.* 大项目时处理)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
