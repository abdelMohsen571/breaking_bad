import 'package:breaking_bad/busniss_logic/characters_cubit.dart';

import 'package:breaking_bad/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Charcters.dart';
import '../widgets/charcters_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Character>? allCharcters;

  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.swatchColor,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.swatchColor, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.swatchColor, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharcters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.swatchColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.swatchColor,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? _buildSearchField()
              : Text(
                  "Charcters",
                  style: TextStyle(color: MyColors.secondaruColor),
                ),
          leading: _isSearching
              ? BackButton(
                  color: Colors.yellow,
                )
              : Container(),
          actions: _buildAppBarActions(),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
          if (state is CharactersLoaded) {
            allCharcters = state.characters;
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: _searchTextController.text.isEmpty
                            ? allCharcters!.length
                            : searchedForCharacters.length,
                        itemBuilder: (context, index) => CharctersItem(
                              _searchTextController.text.isEmpty
                                  ? allCharcters![index]
                                  : searchedForCharacters[index],
                            ))
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.blue,
            ));
          }
        }));
  }
}
