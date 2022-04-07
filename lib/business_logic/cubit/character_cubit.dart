import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shows_hub/data/api/character_api.dart';
import 'package:shows_hub/data/models/character_model.dart';
import 'package:shows_hub/data/models/qoute_model.dart';
import 'package:shows_hub/data/repositories/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];
  List<Quote> characterQuotes = [];

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  List<Quote> getCharacterQuotes(String characterName) {
    characterRepository.getCharacterQuotes(characterName).then((quotes) {
      emit(QuotesLoaded(quotes));
      this.characterQuotes = quotes;
    });
    return characterQuotes;
  }
}
