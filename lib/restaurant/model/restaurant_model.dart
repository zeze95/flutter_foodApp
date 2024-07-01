import '../../common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}


class RestaurantModel {

  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name, required this.thumbUrl,
    required this.tags, required this.priceRange,
    required this.ratings, required this.ratingsCount,
    required this.deliveryTime, required this.deliveryFee,
  });

  factory RestaurantModel.fromJson({required Map<String, dynamic> json}){
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: 'http://$ip${json['thumbUrl']}',
        tags: List<String>.from(json['tags']),
        // 다이나믹 타입으로 확인되어 오류가 되기에 from을 통하여 문자배열에 넣어줌
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json['priceRange']),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee']);
  }
}
