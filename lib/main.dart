import 'package:breaking_bad/busniss_logic/characters_cubit.dart';
import 'package:breaking_bad/data/repositry/charcters_repository.dart';
import 'package:breaking_bad/data/web_services/charcters_api.dart';
import 'package:breaking_bad/presentation/screens/charcters_details_screen.dart';
import 'package:breaking_bad/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) =>
        CharactersCubit(CharactersRepository(CharactersWebServices())),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breaking Bad',
      theme: ThemeData(
        primaryColor: Color(0xffFFc107),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CharctersDetails.routeName: (context) => CharctersDetails(),
      },
    );
  }
}
