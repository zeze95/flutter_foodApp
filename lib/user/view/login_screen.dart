import 'dart:convert';
import 'dart:io';

import 'package:baemin/common/component/custom_text_form_field.dart';
import 'package:baemin/common/const/colors.dart';
import 'package:baemin/common/const/data.dart';
import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final emulatorIP = '10.0.2.2:3000'; // 안드로이드
    final simulatorIP = '127.0.0.1:3000'; // ios
    final ip = Platform.isIOS ? simulatorIP : emulatorIP;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // 키보드갸 활성된 상태일때 드래그 되면 키보드가 내려감
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력하세요',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력하세요',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    //id: 비밀번호
                    // final rawString = 'test@codefactory.ai:testtest';
                    final rawString = '$username:$password';
                    Codec<String,String> stringToBase64 = utf8.fuse(base64);
                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',options: Options(headers: {'authorization': 'Basic $token'}));
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);


                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RootTab()));
                    print('ffff ${resp.data}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                  onPressed: ()  async {

                  },
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해주세요! \n오늘도 성공적인 주문이 되길',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
