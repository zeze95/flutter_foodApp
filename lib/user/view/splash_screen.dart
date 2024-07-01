import 'package:baemin/common/const/colors.dart';
import 'package:baemin/common/const/data.dart';
import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/common/view/root_tab.dart';
import 'package:baemin/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    print('initState');
    super.initState();
    // deleteToken();
    checkToken ();
  }
  void deleteToken() async {
    print('deleteToken');
    await storage.deleteAll();
  }
  void checkToken () async {
    print('checkToken');
    final refreshToken = await storage.read(key:REFRESH_TOKEN_KEY);
    final accessToken =  await storage.read(key: ACCESS_TOKEN_KEY);
    final dio = Dio();

    try{
      final resp = await dio.post('http://$ip/auth/token',options: Options(headers: {'authorization': 'Bearer $refreshToken'}));
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>RootTab()), (route)=>false);
      print('refreshToken true');
    }catch(err){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LoginScreen()), (route)=>false);
      print('refreshToken false');
    }

    // if (refreshToken == null|| accessToken ==null ){
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LoginScreen()), (route)=>false);
    // }else{
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>RootTab()), (route)=>false);
    // }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroudColor: PRIMARY_COLOR,
        child: SizedBox(
          width : MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
