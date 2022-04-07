import 'package:flutter/material.dart';
import 'package:shows_hub/constants/colors.dart';
import 'package:shows_hub/constants/strings.dart';
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
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScreenRoute,
            arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: grey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
