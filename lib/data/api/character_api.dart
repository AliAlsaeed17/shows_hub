import 'package:dio/dio.dart';
import 'package:shows_hub/constants/strings.dart';

class CharacterApi {
  late Dio dio;

  CharacterApi() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000, // 20 seconds,
      receiveTimeout: 30 * 1000,
    );
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String characterName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {"author": characterName});
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
