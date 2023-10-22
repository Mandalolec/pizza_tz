import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_tz/presentation//pages/home_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PizzaFromLocalJsonFileRepository(),
      child: BlocProvider(
        create: (context) => PizzaBloc(
          pizzaRepository: RepositoryProvider.of<PizzaFromLocalJsonFileRepository>(context),
        )..add(PizzaLoadEvent()),
        child: MaterialApp(
            title: 'Demo',
            theme: ThemeData(
              primaryColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.white,
              textTheme: GoogleFonts.ptSerifCaptionTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: const HomePage()),
      ),
    );
  }
}
