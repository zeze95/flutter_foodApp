import 'package:baemin/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image; // 이미지
  final String name; // 레스토랑 이름
  final List<String> tags; // 레스토랑 태그
  final int ratingCount; // 평점 갯수
  final int deliveryTime; // 배달 시간
  final int deliveryFee; // 배달비
  final double ratings; // 평균 평점

  const RestaurantCard(
      {required this.image,
      required this.name,
      required this.tags,
      required this.ratingCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        SizedBox(
          height: 16.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(tags.join(' • ')),
            // join을 쓰면 배열의 값마다 하나씩 쓰고 파라미터 안에 있는 문자열로 저장됨
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                renderDot(),
                _IconText(icon: Icons.star, label: ratings.toString()),
                renderDot(),
                _IconText(icon: Icons.receipt, label: ratingCount.toString()),
                _IconText(
                    icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                renderDot(),
                _IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? '무료' : deliveryFee.toString()),
              ],
            )
          ],
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
