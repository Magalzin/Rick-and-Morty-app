import 'package:flutter/material.dart';
import 'package:rick_and_morty_work/repository/models/character_model.dart';

class CharacterPopUp extends StatelessWidget {
  final CharacterModel character;

  const CharacterPopUp({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isSmallScreen = screenWidth < 500;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content:
          isSmallScreen
              ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        character.image,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _CharacterInfo(
                    character: character,
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              )
              : SizedBox(
                width: screenWidth * 0.8 > 500 ? screenWidth * 0.6 : 500,
                height: screenWidth * 0.3 > 200 ? screenWidth * 0.4 : 200 ,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        character.image,
                        fit: BoxFit.cover,
                        height: (screenWidth * 0.4) > 200 ? screenWidth * 0.4 : 200,
                        width:  (screenWidth * 0.4) > 200 ? screenWidth * 0.4 : 200,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Center(
                        child: _CharacterInfo(
                          character: character,
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  final CharacterModel character;
  final bool isSmallScreen;
  const _CharacterInfo({required this.character, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        isSmallScreen ? const SizedBox(height: 10) : const SizedBox(height: 35),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Status: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: character.status,
                style: TextStyle(
                  color:
                      character.status == "Alive"
                          ? Colors.green
                          : character.status == "Dead"
                          ? Colors.red
                          : Colors.grey,
                ),
              ),
              const TextSpan(text: "\n"),
              TextSpan(
                text: "Espécie: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: character.species),
              const TextSpan(text: "\n"),
              TextSpan(
                text: "Gênero: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: character.gender),
              const TextSpan(text: "\n"),
              TextSpan(
                text: "Tipo: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: character.type.isEmpty ? "N/A" : character.type),
            ],
          ),
        ),
      ],
    );
  }
}
