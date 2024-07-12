import 'package:baemin/restaurant/model/restaurant_detail_model.dart';
import 'package:baemin/common/model/cursor_pagination_model.dart';
import 'package:baemin/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'restaurant_respository.g.dart';

@RestApi()
abstract class RestaurantRespository {
  //http://$ip/restaurant 을 디폴트로
  factory RestaurantRespository(Dio dio, {String baseUrl}) =
      _RestaurantRespository;

  //http://$ip/restaurant/
  @GET('/')
  @Headers({'accessToken':'true'})
  Future<CursorPagination<RestaurantModel>> paginate();


  //http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({'accessToken':'true'})  // 여기에 토큰을 직접 넣지 않았어도 토큰이 필요하면 common/dio/dio.dart를 통해 토큰을 달아 보냄options.headers 통해서 이 걸 확인함
  Future<RestaurantDetailModel> getRestaurauntDetail({
    @Path() required String id, // path 어노테이션을 이용해서 id를 보내주는데 이 id라는 변수가 GET 변수와 동일한 이름을 넣어주면 됨
    // @Path(id) required String newId 이렇게 하면 NewID가 id랑 다르지만 path(id)를 통해  @GET('/{id}')로들어감
  });

//abstract 함수를 썻기에 내부의 paginate나 getRestaurauntDetail 라고 선언한 함수는
// {}를 넣지않는데 어떤함수가 있을건지만 써두는게 목적
}
