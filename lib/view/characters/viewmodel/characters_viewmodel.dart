import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_work/core/entites/request_state_entity.dart';
import 'package:rick_and_morty_work/repository/characters_repository.dart';
import 'package:rick_and_morty_work/repository/models/character_model.dart';





class CharactersViewModel extends Cubit<IRequestState<List<CharacterModel>>> {
  final ICharactersRepository _charactersRepository;

  CharactersViewModel(this._charactersRepository)
    : super(const RequestInitiationState<List<CharacterModel>>());

  Future<void> getAllCharacters() async {
    emit(const RequestProcessingState<List<CharacterModel>>());

    try {
      final characters = await _charactersRepository.getAllCharacters();
      emit(RequestCompletedState<List<CharacterModel>>(value: characters));
    } catch (error) {
      emit(RequestErrorState<List<CharacterModel>>(error: error));
    }
  }
  Future<void> searchCharacters(String name) async {
    emit(const RequestProcessingState<List<CharacterModel>>());

    try {
      final characters = await _charactersRepository.searchCharacters(name);
      emit(RequestCompletedState<List<CharacterModel>>(value: characters));
    } catch (error) {
      emit(RequestErrorState<List<CharacterModel>>(error: "Não foi possível encontrar personagens com o nome: $name"));
    }
  }
}
