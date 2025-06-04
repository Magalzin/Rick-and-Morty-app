import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rick_and_morty_work/core/entites/http_response_entity.dart';

abstract interface class IHttpService {
  Future<HttpResponseEntity> get(String url);
}

final class HttpService implements IHttpService {
  const HttpService();

  @override
  Future<HttpResponseEntity> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      return HttpResponseEntity(data: null, statusCode: 5100);
    }
  }

  HttpResponseEntity _createHttpResponseFromResponse(Response response) {
    return HttpResponseEntity(
      data: response.body,
      statusCode: response.statusCode,
    );
  }
}
