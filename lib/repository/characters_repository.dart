import 'package:rick_and_morty_work/repository/models/character_model.dart';
import 'package:rick_and_morty_work/service/characters_service.dart';

abstract interface class ICharactersRepository {
  Future<List<CharacterModel>> getAllCharacters();
  Future<List<CharacterModel>> searchCharacters(String name);
}

final class CharactersRepository implements ICharactersRepository {
  final ICharactersService _charactersService;

  CharactersRepository(this._charactersService);

  List<CharacterModel> _charactersCache = [];

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    print('Fetching all characters...');
    if (_charactersCache.isNotEmpty) {
      return _charactersCache;
    }
    int numberOfPages = 1;
    do {
      print('Fetching page $numberOfPages of characters... : $numberOfPages');
      final response = await _charactersService.getCharacters(numberOfPages);
      final charactersGetted =
          (response.data as List)
              .map((character) => CharacterModel.fromJson(character))
              .toList();
      _charactersCache.addAll(charactersGetted);
      numberOfPages++;
    } while (numberOfPages <= 42);

    return _charactersCache;
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String name) async {
    if (_charactersCache.isEmpty) {
      await getAllCharacters();
    }

    final filteredCharacters =
        _charactersCache
            .where(
              (character) =>
                  character.name.toLowerCase().contains(name.toLowerCase()),
            )
            .toList();

    if (filteredCharacters.isNotEmpty) {
      return filteredCharacters;
    } else {
      throw Exception('No characters found with the name: $name');
    }
  }
}
