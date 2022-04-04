import 'package:shows_hub/data/api/character_api.dart';
import 'package:shows_hub/data/models/character_model.dart';

class CharacterRepository {
  final CharacterApi characterApi;

  CharacterRepository(this.characterApi);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterApi.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
