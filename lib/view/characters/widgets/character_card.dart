import 'package:flutter/material.dart';
import 'package:rick_and_morty_work/repository/models/character_model.dart';
import 'package:rick_and_morty_work/view/characters/widgets/character_popup_card.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CharacterPopUp(character: character),
        );
      },
      child: LayoutBuilder(
        builder: (context, constrains) {
          bool isHeightGreaterThan300 =
              constrains.maxHeight > 360 ? true : false;
          return Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  child: Image.network(
                    character.image,
                    fit: BoxFit.fill,
                    width: constrains.maxWidth,
                    height: constrains.maxHeight * 0.76,
                  ),
                ),
                Padding(
                  padding:
                      isHeightGreaterThan300
                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                          : EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                  child: SizedBox(
                    width: constrains.maxWidth,
                    child: Text(
                      character.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: isHeightGreaterThan300 ? 20 : 13,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      isHeightGreaterThan300
                          ? EdgeInsets.symmetric(horizontal: 10)
                          : EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Especie: ${character.species}",
                    style: TextStyle(
                      fontSize: isHeightGreaterThan300 ? 20 : 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
