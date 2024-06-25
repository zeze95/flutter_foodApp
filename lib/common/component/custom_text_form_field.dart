import 'package:baemin/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final bool autoFocus;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;


  const CustomTextFormField(
      { this.obscureText = false,
        this.autoFocus = false,
        this.hintText,
        this.errorText,
        required this.onChanged, // 무조건 받아야함
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder( // 테두리가 있는 보더로~
        borderSide: BorderSide(
            color: INPUT_BORDER_COROR,
            width: 1.0
        )
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: PRIMARY_COLOR,
        obscureText: obscureText, // 비밀번호 입력 암호화된 입력이 됨
        autofocus: autoFocus, // 위젯이 생성될때 자동으로 포커스됨
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          //false - 배경색 없음 , true - 배경색 있음
          // 모든 input상태의 기본 스타일 세팅
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
                color: PRIMARY_COLOR // basebBorder에서 색상만 변경하여 입력하겠다는 copyWith
            ),
          ),

        ),
      ),
    );
  }
}
