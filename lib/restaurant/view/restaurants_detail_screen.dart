import 'package:baemin/common/layout/defalut_layout.dart';
import 'package:baemin/product/componet/product_card.dart';
import 'package:baemin/restaurant/component/restaurant_card.dart';
import 'package:baemin/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantsDetailScreen extends StatelessWidget {
  const RestaurantsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              fit: BoxFit.cover,
            ),
            name: '불타는 떡볶이',
            tags: ['떡볶이', '치즈', '매운맛'],
            ratingsCount: 100,
            ratings: 4.52,
            deliveryTime: 15,
            deliveryFee: 2000,
            isDetail: true,
            priceRange: RestaurantPriceRange.cheap,
            detail: '맛있는 떡볶이',
          ),
          // ProductCard(),
        ],
      ),
    );
  }
}

