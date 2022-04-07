import 'package:shows_hub/data/api/character_api.dart';
import 'package:shows_hub/data/models/character_model.dart';

import '../models/qoute_model.dart';

class CharacterRepository {
  final CharacterApi characterApi;

  CharacterRepository(this.characterApi);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterApi.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterQuotes(String characterName) async {
    final quotes = await characterApi.getCharacterQuotes(characterName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
