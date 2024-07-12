import 'package:baemin/common/const/data.dart';
import 'package:baemin/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'restaurant_model.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;


  RestaurantDetailModel(
      {required super.id,
      required super.name,
      @JsonKey(fromJson: DataUitls.pathToUrl) required super.thumbUrl,
      required super.tags,
      required super.priceRange,
      required super.ratings,
      required super.ratingsCount,
      required super.deliveryTime,
      required super.deliveryFee,
      required this.detail,
      required this.products});

  factory RestaurantDetailModel.fromJson(Map<String, dynamic>json)
  => _$RestaurantDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantDetailModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: 'http://$ip${json['thumbUrl']}',
  //       tags: List<String>.from(json['tags']),
  //       // 다이나믹 타입으로 확인되어 오류가 되기에 from을 통하여 문자배열에 넣어줌
  //       priceRange: RestaurantPriceRange.values
  //           .firstWhere((e) => e.name == json['priceRange']),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee'],
  //       detail: json['detail'],
  //       products: json['products']
  //           .map<RestaurantProductModel>(
  //             (x) => RestaurantProductModel.fromJson(json: x),
  //           )
  //           .toList());
  // }
}
@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
      fromJson:DataUitls.pathToUrl
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});

  // factory RestaurantProductModel.fromJson(
  //     {required Map<String, dynamic> json}) {
  //   return RestaurantProductModel(
  //       id: json['id'],
  //       name: json['name'],
  //       imgUrl: 'http://$ip${json['imgUrl']}',
  //       detail: json['detail'],
  //       price: json['price']);
  // }

  factory RestaurantProductModel.fromJson(Map<String,dynamic> json)
  => _$RestaurantProductModelFromJson(json); // 스니펫으로 만들수있게 해뒀움

  //
  // static pathToUrl(String value) {
  //   return 'http://$ip${value}';
  // }

}
