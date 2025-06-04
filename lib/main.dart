import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_work/core/instances/get_instances.dart';
import 'package:rick_and_morty_work/core/theme/theme_cubit.dart';
import 'package:rick_and_morty_work/view/characters/characters_view.dart';
import 'package:rick_and_morty_work/view/characters/viewmodel/characters_viewmodel.dart';

void main() {
  initCharactersInstances();
  runApp(BlocProvider(create: (_) => ThemeCubit(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightGreenAccent,
              brightness: Brightness.dark,
            ),
          ),
          home: BlocProvider(
            create:
                (context) =>
                    getItInstance<CharactersViewModel>()..getAllCharacters(),
            child: CharactersView(),
          ),
        );
      }
    );
  }
}
