import 'package:baemin/common/component/custom_text_form_field.dart';
import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/user/view/login_screen.dart';
import 'package:baemin/user/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
