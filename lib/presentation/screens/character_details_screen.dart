import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/character_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getCharacterQuotes(character.name);
    return Scaffold(
      backgroundColor: grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterInfo('Job: ', character.jobs.join(' / ')),
                      buildDivider(315),
                      CharacterInfo('Appeared In: ', character.category),
                      buildDivider(250),
                      CharacterInfo(
                          'Seasons: ', character.appearance.join(' / ')),
                      buildDivider(280),
                      CharacterInfo('Status: ', character.status),
                      buildDivider(300),
                      CharacterInfo('Actor/Actress: ', character.actorName),
                      buildDivider(235),
                      SizedBox(height: 20),
                      BlocBuilder<CharacterCubit, CharacterState>(
                        builder: (context, state) {
                          return checkIfQuotesLoaded(state);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: grey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: white),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget CharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesLoaded(CharacterState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: white,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: yellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(
                quotes[randomIndex].quote,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: yellow,
      ),
    );
  }
}
