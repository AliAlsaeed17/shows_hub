import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shows_hub/business_logic/cubit/character_cubit.dart';
import 'package:shows_hub/constants/colors.dart';
import 'package:shows_hub/data/models/character_model.dart';
import 'package:shows_hub/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  bool _isSearching = false;
  final TextEditingController _searchTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        leading: _isSearching
            ? BackButton(
                color: grey,
              )
            : Container(),
        title: _isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: grey),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextFieldController,
      cursorColor: grey,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: grey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: grey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        searchForCharacter(searchedCharacter);
      },
    );
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: grey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search, color: grey),
        ),
      ];
    }
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else {
          return showProgressIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: grey,
        child: buildCharactersList(),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextFieldController.text.isEmpty
          ? allCharacters.length
          : searchedCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextFieldController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        );
      },
    );
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: yellow,
      ),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextFieldController.clear();
    });
  }

  void searchForCharacter(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }
}
