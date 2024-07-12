import 'package:baemin/common/const/colors.dart';
import 'package:baemin/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard(
      {required this.image, required this.name, required this.detail, required this.price, super.key});

  factory ProductCard.fromModel({required RestaurantProductModel model,
  }){
    return ProductCard(image: Image.network(model.imgUrl,width: 110,height: 110,fit: BoxFit.cover,), name: model.name, detail: model.detail, price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: image
          // Image.asset(
          //   'asset/img/food/ddeok_bok_gi.jpg',
          //   width: 110,
          //   height: 110,
          //   fit: BoxFit.cover,
          // )
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis, // detail의 글이 길면 ...으로 잘림
                  style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
                ),
                Text(
                  '₩$price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),

              ],
            ))
      ],
    );
  }
}
