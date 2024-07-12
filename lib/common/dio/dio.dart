// 1. 요청 보낼때
// 2. 응답을 받을때
// 3. 에러가 났을때
// 이 세가지 경우에 대해서 중간에서 가로채서 값을 바꿔서 반환하는 것이 가능

import 'package:baemin/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

// 1. 요청 보낼때 (보내기 전)
  // 요청이 보내질 때마다
  // 만약에 요청의 Header에 ['accessToken'] == 'true' 라는 값이 있다면
  // 실제 토큰을 가져와 (storage에서) 'authorization': 'Bearer $token' 으로
  // 헤더를 변경한다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("[REQ] [${options.method}],${options.uri}, ${options.headers}");
    //: [REQ] [GET],http://127.0.0.1:3000/restaurant/5ac83bfb-f2b5-55f4-be3c-564be3f01a5b/5ac83bfb-f2b5-55f4-be3c-564be3f01a5b
    // 라고 찍히는게 확인됨
    if (options.headers['accessToken'] == 'true') {
      // 보내려는 요청의 헤더를 가져옴
      options.headers.remove('accessToken'); // 키를 지움
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      // 삭제하였으니 새로운 토큰을 입력함
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    if (options.headers['refreshToken'] == 'true') {
      // 보내려는 요청의 헤더를 가져옴
      options.headers.remove('refreshToken'); // 키를 지움
      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      // 삭제하였으니 새로운 토큰을 입력함
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    if (!(options.headers['accessToken'] == 'true') ||
        !(options.headers['refreshToken'] == 'true')) {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    // 이 else는 강의에 없었으나 계속 오류가 나는디... header를 프린트 찍으면 'authorization': 'Bearer $token 이 나옴
    // 그래서 둘다 있으면 이렇게 해주는걸로 우선 해둠 오류나는 방향을 못잡겠으 ㅠ

    return super.onRequest(options, handler);
  }

// 2. 응답을 받을때
  // 정상적인 응답을 받을때만 사용하는거라서 딱히 필요없으나
  // 혹시라도 받은 응답코드가 201이나 202일때 따로따로 정해져있다면 여기서 모든 올케어
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("[RES] [${response.requestOptions.method}],${response.requestOptions.uri}, ${response.requestOptions.headers}");
    switch (response.statusCode) {
    case 200:
    // Handle status code 200
    print('Status Code 200: OK');
    // Add your custom logic for 200 here
    // case 201:
    // // Handle status code 201
    // print('Status Code 201: Created');
    // // Add your custom logic for 201 here
    // break;
    default:
    // Handle other status codes
    print('Status Code ${response.statusCode}: ${response.statusMessage}');
    // Add your custom logic for other status codes here
    // break;
    }
    return super.onResponse(response, handler);
  }



// 3. 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을때 (status code) 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰을 요청을 한다
    print('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    // refresh 토큰이 없으면 에러를 던진다
    if (refreshToken == null) {
      // 에러를 던질땐 handler.reject 를 사용한다
      return handler.reject(err);
    }
    final isStatus401 = err.response?.statusCode == 401;
    // 401이면 true

    final isPathRefresh = err.requestOptions.path == '/auth/token';
    // 토큰을 리프레시 하려다가 에러가 난거냐~
    // true라면 리프레시 토큰자체에 문제가 생기는거라서 이럴땐 리젝를 해줘야함
    if (isStatus401 && !isPathRefresh) {
      //401에러인데 리프레시를 하려는 의도가 아니였다면
      try {
        final dio = Dio();
        final resp = await dio.post('http://$ip/auth/token',
            options:
                Options(headers: {'authorization': 'Bearer $refreshToken'}));
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;
        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        //새로 resp 받은 에세스 토큰을 헤더에 담아 이번 요청에만 사용하도록 한것이지
        //스토리지에 담진 않았음
        // 그래서 스토리지에 다시 써야함
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // fetch를통해 다시 요청을 보내는 것
        final response = await dio.fetch(options);
        // 새로 보낸 요청에 대한 핸들러를 하는것
        return handler.resolve(response);
        // 실제로 에러가 났지만 토큰들을 수정하여 다시 보냈고
        // 에러가 나지않은 것처럼 착각하게 만들수있음
        // 만약 그럼에도 오류가 난다면 밑에 캐치로 넘어가겠지

      } on DioException catch (error) {
        return handler.reject(err);
        // 에러를 그대로 돌려줌

      }
    }



    // return super.onError(err, handler);
  }
}
