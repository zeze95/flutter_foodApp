import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child; // 외부에서 위젯을 받는다
  final Color? backgroudColor;
  final String? title ;
  final Widget? bottomNavigationBar ;
  const DefaultLayout({required this.child, this.backgroudColor,this.title,this.bottomNavigationBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      appBar: renderAppBar(),
      backgroundColor: backgroudColor ?? Colors.white,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar(){
    if(title == null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(title!,style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500
        ),),
        foregroundColor: Colors.black,
      );
    }
  }
}
