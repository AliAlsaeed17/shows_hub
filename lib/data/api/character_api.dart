import 'package:dio/dio.dart';
import 'package:shows_hub/constants/strings.dart';
import 'package:shows_hub/data/models/character_model.dart';

class CharacterApi {
  late Dio dio;

  CharacterApi() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds,
      receiveTimeout: 20 * 1000,
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
}
