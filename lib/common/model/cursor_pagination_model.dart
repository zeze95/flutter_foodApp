import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';


@JsonSerializable(
  genericArgumentFactories: true
)
class CursorPagination<T> {

  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  factory CursorPagination.fromJson(Map<String,dynamic> json, T Function(Object? json) fromJsonT)
  // T Function을 통해 밑으로 보내줘야 모델 타입을 몰라서 생기는 g.dart파일내의 오류가 없어짐
  => _$CursorPaginationFromJson(json,fromJsonT);
  // Map<String, dynamic> toJson() => _$CursorPaginationToJson(this);
}

@JsonSerializable()
class CursorPaginationMeta {

  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore
  });
 factory CursorPaginationMeta.fromJson(Map<String,dynamic> json)
 => _$CursorPaginationMetaFromJson(json);
  // Map<String, dynamic> toJson() => _$CursorPaginationMetaToJson(this);
}
