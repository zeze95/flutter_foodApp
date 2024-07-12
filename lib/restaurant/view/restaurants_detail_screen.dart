import 'package:baemin/common/const/data.dart';
import 'package:baemin/common/dio/dio.dart';
import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/product/componet/product_card.dart';
import 'package:baemin/restaurant/component/restaurant_card.dart';
import 'package:baemin/restaurant/model/restaurant_detail_model.dart';
import 'package:baemin/restaurant/model/restaurant_model.dart';
import 'package:baemin/restaurant/repository/restaurant_respository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantsDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantsDetailScreen({required this.id, super.key});


    // Future<Map<String, dynamic>> getRestaurantDetail() async   레포지토리 파일로 넘어가기
  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    // final resp = await dio.get('http://$ip/restaurant/$id',
    //     options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    // return resp.data; 레포지토리 파일로 넘어가기
      dio.interceptors.add(
        CustomInterceptor(storage: storage),
      );
    final repository = RestaurantRespository(dio,baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurauntDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      // child: Column(
      //   children: [
      //     RestaurantCard(
      //       image: Image.asset(
      //         'asset/img/food/ddeok_bok_gi.jpg',
      //         fit: BoxFit.cover,
      //       ),
      //       name: '불타는 떡볶이',
      //       tags: ['떡볶이', '치즈', '매운맛'],
      //       ratingsCount: 100,
      //       ratings: 4.52,
      //       deliveryTime: 15,
      //       deliveryFee: 2000,
      //       isDetail: true,
      //       priceRange: RestaurantPriceRange.cheap,
      //       detail: '맛있는 떡볶이',
      //     ),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16.0), child:ProductCard(),)
      //     ,
      //   ],
      // 1.정적으로 만들기
      // ),
      // child: CustomScrollView(
      //   slivers: [rendderTop(), renderLabel(), renderProducts()],
      // ),
      //2.커스텀 스크롤 뷰로 만들기
      // child: FutureBuilder<Map<String, dynamic>>( 레파지토리로 넘어감
      child: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(),
        // builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) { 레파지토리로 넘어감
          builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          //   if (snapshot.hasError) {
          //       return Text('${snapshot.error.toString()}');
          //   }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // final item = RestaurantDetailModel.fromJson(snapshot.data!); 레파지토리로 넘어가고 모델링이 된 게 스냅샷으로 들어올것
          return CustomScrollView(
            slivers: [
              // rendderTop(model: item), 레파지토리를 통해 아이템 안쓰게됨
              rendderTop(model: snapshot.data!),
              renderLabel(),
              // renderProducts(products: item.products) 레파지토리를 통해 아이템 안쓰게됨
              renderProducts(products: snapshot.data!.products)
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter rendderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
      // child: RestaurantCard(
      //   image: Image.asset(
      //     'asset/img/food/ddeok_bok_gi.jpg',
      //     fit: BoxFit.cover,
      //   ),
      //   name: '불타는 떡볶이',
      //   tags: ['떡볶이', '치즈', '매운맛'],
      //   ratingsCount: 100,
      //   ratings: 4.52,
      //   deliveryTime: 15,
      //   deliveryFee: 2000,
      //   isDetail: true,
      //   priceRange: RestaurantPriceRange.cheap,
      //   detail: '맛있는 떡볶이',
      // ),
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final model = products[index];
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ProductCard.fromModel(model: model),
              );
            },
            childCount: products.length,
          ),
        ));
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
