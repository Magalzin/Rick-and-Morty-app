import 'dart:convert';

import 'package:rick_and_morty_work/core/entites/http_response_entity.dart';
import 'package:rick_and_morty_work/core/helpers/enviroment_helper.dart';
import 'package:rick_and_morty_work/core/service/http_service.dart';

abstract interface class ICharactersService {
  Future<HttpResponseEntity> getCharacters(int page);
}

final class CharactersService implements ICharactersService {
  final IHttpService _httpService;
  final IEnvironmentHelper _environmentHelper;

  const CharactersService(this._httpService, this._environmentHelper);

  @override
  Future<HttpResponseEntity> getCharacters(int page) async {
    final url = '${_environmentHelper.baseUrl}$page';

    print('Fetching characters from: $url');
    try {
      final response = await _httpService.get(url);
      final decoded = jsonDecode(response.data);
      
      return HttpResponseEntity(
        data: decoded['results'],
        statusCode: response.statusCode,
      );
    } catch (error) {
      return HttpResponseEntity(data: null, statusCode: 500);
    }
  }
}