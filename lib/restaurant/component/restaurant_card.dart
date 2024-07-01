import 'package:baemin/common/const/colors.dart';
import 'package:baemin/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image; // 이미지
  final String name; // 레스토랑 이름
  final List<String> tags; // 레스토랑 태그
  final int ratingsCount; // 평점 갯수
  final RestaurantPriceRange priceRange;
  final int deliveryTime; // 배달 시간
  final int deliveryFee; // 배달비
  final double ratings; // 평균 평점
  final bool isDetail; // 상세 페이지냐 아니냐
  final String? detail; //상세내용

  const RestaurantCard(
      {required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.priceRange,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      this.isDetail = false,
      this.detail,
      super.key});

  factory RestaurantCard.fromModel(
      {required RestaurantModel model, bool isDetail = false}) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      priceRange: model.priceRange,
      ratingsCount: model.ratingsCount,
      ratings: model.ratings,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: image,
          ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(tags.join(' • ')),
              // join을 쓰면 배열의 값마다 하나씩 쓰고 파라미터 안에 있는 문자열로 저장됨
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  renderDot(),
                  _IconText(icon: Icons.star, label: ratings.toString()),
                  renderDot(),
                  _IconText(
                      icon: Icons.receipt, label: ratingsCount.toString()),
                  _IconText(
                      icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                  renderDot(),
                  _IconText(
                      icon: Icons.monetization_on,
                      label: deliveryFee == 0 ? '무료' : deliveryFee.toString()),
                ],
              ),
              if(detail !=null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

renderDot() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      ' •',
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
