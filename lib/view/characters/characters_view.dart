import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_work/core/entites/request_state_entity.dart';
import 'package:rick_and_morty_work/core/theme/theme_cubit.dart';
import 'package:rick_and_morty_work/repository/models/character_model.dart';
import 'package:rick_and_morty_work/view/characters/viewmodel/characters_viewmodel.dart';
import 'package:rick_and_morty_work/view/characters/widgets/character_card.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Rick and Morty Work',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(context.read<ThemeCubit>().currentIcon),
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth;

            int axisCount = (width / 300).floor().clamp(2, 5);

            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    context.read<CharactersViewModel>().searchCharacters(value);
                  },
                ),
                Expanded(
                  child: BlocConsumer<
                    CharactersViewModel,
                    IRequestState<List<CharacterModel>>
                  >(
                    builder: (context, state) {
                      if (state is RequestInitiationState ||
                          state is RequestProcessingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is RequestCompletedState) {
                        final characters = state.data;
                        return GridView.builder(
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: axisCount,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 8.0,
                              ),
                          itemCount: characters.length,
                          itemBuilder: (context, index) {
                            final character = characters[index];
                            return CharacterCard(character: character);
                          },
                        );
                      }
                      return const Center(child: Text('No data available'));
                    },
                    listener: (
                      BuildContext context,
                      IRequestState<List<CharacterModel>> state,
                    ) {
                      if (state is RequestErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.error}')),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
