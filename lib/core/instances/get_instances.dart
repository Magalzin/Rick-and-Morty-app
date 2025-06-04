import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_work/core/helpers/enviroment_helper.dart';
import 'package:rick_and_morty_work/core/service/http_service.dart';
import 'package:rick_and_morty_work/repository/characters_repository.dart';
import 'package:rick_and_morty_work/service/characters_service.dart';
import 'package:rick_and_morty_work/view/characters/viewmodel/characters_viewmodel.dart';

final getItInstance = GetIt.instance;

void initCharactersInstances() {
  if (!getItInstance.isRegistered<IEnvironmentHelper>()) {
    getItInstance.registerLazySingleton<IEnvironmentHelper>(
      () => EnvironmentHelper(),
    );
  }

  if (!getItInstance.isRegistered<IHttpService>()) {
    getItInstance.registerLazySingleton<IHttpService>(() => HttpService());
  }

  if (!getItInstance.isRegistered<ICharactersService>()) {
    getItInstance.registerLazySingleton<ICharactersService>(
      () => CharactersService(
        getItInstance<IHttpService>(),
        getItInstance<IEnvironmentHelper>(),
      ),
    );
  }

  if (!getItInstance.isRegistered<ICharactersRepository>()) {
    getItInstance.registerLazySingleton<ICharactersRepository>(
      () => CharactersRepository(getItInstance<ICharactersService>()),
    );
  }

  if (!getItInstance.isRegistered<CharactersViewModel>()) {
    getItInstance.registerFactory<CharactersViewModel>(
      () => CharactersViewModel(getItInstance<ICharactersRepository>()),
    );
  }
}
