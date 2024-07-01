import 'package:baemin/restaurant/component/restaurant_card.dart';
import 'package:baemin/restaurant/model/restaurant_model.dart';
import 'package:baemin/restaurant/view/restaurants_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    print("paginateRestaurant");
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List>(
                builder: (context, AsyncSnapshot<List> snapshot) {
                  print("paginateRestaurant error");
                  print(snapshot.error);
                  print("paginateRestaurant data");
                  print(snapshot.data);

                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.length, // 몇개의 레스토랑이 있을지 데이터 양만큼
                    itemBuilder: (_, index) {
                      final item = snapshot.data![index];
                      final pItem = RestaurantModel.fromJson(json: item);
                      // final pItem = RestaurantModel(
                      //     id: item['id'],
                      //     name: item['name'],
                      //     thumbUrl: 'http://$ip${item['thumbUrl']}',
                      //     tags: List<String>.from(item['tags']),
                      //     // 다이나믹 타입으로 확인되어 오류가 되기에 from을 통하여 문자배열에 넣어줌
                      //     priceRange: RestaurantPriceRange.values
                      //         .firstWhere((e) => e.name == item['priceRange']),
                      //     ratings: item['ratings'],
                      //     ratingsCount: item['ratingsCount'],
                      //     deliveryTime: item['deliveryTime'],
                      //     deliveryFee: item['deliveryFee']);
                      // 이렇게 쓰던거를 이제 model에 팩토리를 이용해 item을 만들어서 받아옴

                      // return RestaurantCard(
                      //   image: Image.network(
                      //     pItem.thumbUrl,
                      //     fit: BoxFit.cover,
                      //   ),
                      //   name: pItem.name,
                      //   tags: pItem.tags,
                      //   priceRange: pItem.priceRange,
                      //   ratingsCount: pItem.ratingsCount,
                      //   ratings: pItem.ratings,
                      //   deliveryTime: pItem.deliveryTime,
                      //   deliveryFee: pItem.deliveryFee,
                      // );
                      // 레스토랑 카드를 팩토리를 이용해 보내서 사용
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => RestaurantsDetailScreen())
                            );
                          },
                          child: RestaurantCard.fromModel(model: pItem));
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                  );

                  // return RestaurantCard(
                  //   image: Image.asset(
                  //     'asset/img/food/ddeok_bok_gi.jpg', fit: BoxFit.cover,),
                  //   name: '불타는 떡볶이',
                  //   tags: ['떡볶이', '치즈', '매운맛'],
                  //   ratingsCount: 100,
                  //   ratings: 4.52,
                  //   deliveryTime: 15,
                  //   deliveryFee: 2000,
                  // );
                },
                future: paginateRestaurant(),
              ))),
    );
  }
}
