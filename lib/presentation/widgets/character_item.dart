import 'package:flutter/material.dart';
import 'package:shows_hub/constants/colors.dart';
import 'package:shows_hub/data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        child: Container(
          color: grey,
          child: character.image,
        ),
      ),
    );
  }
}
