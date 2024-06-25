import 'package:baemin/common/const/colors.dart';
import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this); //랭스ㅜ는 쓸 컨트롤러가 몇개인지 밑에 홈~프로필까지 4개이기에 4개 SingleTickerProviderStateMixind을 위드해줘야 vsync가능
    controller.addListener(tabListener);
  }
  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), // 이걸 하면 화면 탭바 뷰들간의 좌우 스크롤을 막을수 있음
        controller: controller,
        children: [
          Center(child: RestaurantScreen()),
          Center(child: Container(child: Text('음식'),)),
          Center(child: Container(child: Text('주문'),)),
          Center(child: Container(child: Text('프로필'),)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // type: BottomNavigationBarType.shifting, // 클릭할때 살짝씩 이동됨
        type: BottomNavigationBarType.fixed, // 클릭할때 고정됨
        onTap:(int index){
          // setState(() {
          //   this.index = index;
          // });
          controller.animateTo(index);
          print(index);
        },
        currentIndex: index,
        items: [BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined),label: '음식'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined),label: '주문'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label: '프로필'),
        ],
      ),
    );
  }
}
