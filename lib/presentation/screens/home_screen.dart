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

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Charcters",
            style: TextStyle(color: MyColors.secondaruColor),
          ),
          backgroundColor: MyColors.primaryColor,
        ),
        body: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
          if (state is CharactersLoaded) {
            allCharcters = state.characters;
            return SingleChildScrollView(
              child: Container(
                color: MyColors.swatchColor,
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
                        itemCount: allCharcters!.length,
                        itemBuilder: (context, index) => CharctersItem(
                              allCharcters![index],
                            ))
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.yellow,
            ));
          }
        }));
  }
}
