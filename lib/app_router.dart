import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shows_hub/business_logic/cubit/character_cubit.dart';
import 'package:shows_hub/data/api/character_api.dart';
import 'package:shows_hub/data/repositories/character_repository.dart';
import 'package:shows_hub/presentation/screens/character_details_screen.dart';
import 'package:shows_hub/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterApi());
    characterCubit = CharacterCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharacterCubit(characterRepository),
            child: CharactersScreen(),
          ),
        );
      case charactersDetailsScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const CharacterDetailsScreen());
    }
  }
}
