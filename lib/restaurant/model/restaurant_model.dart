import 'dart:convert';

import 'package:baemin/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../common/const/data.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {

  final String id;
  final String name;
  @JsonKey( // g.dart파일을 수정할수 없으니 thumbUrl을 보낼때 완성된 이미지 주소를 보내기 위해서 이 어노테이션을 이용하여 수정
      fromJson:DataUitls.pathToUrl // json에서 올때 수정하고 싶다면
    // 이렇게 지정해두면 알아서 바로 밑의 thumbUrl 값을 파라미터로 보내고 돌려받은 리턴값을 thumbUrl에 저장해줌
    // toJson:  // json으로 변경될때 수정하고 싶다면
  )
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

  factory RestaurantModel.fromJson(Map<String, dynamic>json)
  => _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

// 파트 로 만들어야할 g.dart파일 이름을 정해놓고
// flutter pub run build_runnder build 명령어를 입력하여
// g.dart 파일을 생성함 하여 해당 팩토리 부분이 넘어가있음
  // factory RestaurantModel.fromJson({required Map<String, dynamic> json}){
  //   return RestaurantModel(
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
  //       deliveryFee: json['deliveryFee']);
  // }

//   static pathToUrl(String value) {
//     // thumbUrl이 value로 알아서 들어옴
//     // static으로 먼든 함수여야만 함
//     return 'http://$ip${value}';
//   } // utils 폴더의 data 파일로 보냄
//
}

