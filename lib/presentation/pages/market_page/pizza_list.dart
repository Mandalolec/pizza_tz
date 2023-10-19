import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_tz/data/model/pizza.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_tz/domain/repository/pizza_repository.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPizzaWidget();
  }
}

class ListPizzaWidget extends State<PizzaList> {
  List<Pizza> pizzas = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PizzaBloc(PizzaLoadingState(), pizzaRepository: PizzaRepository())
            ..add(PizzaLoadEvent()),
      child: BlocListener<PizzaBloc, PizzaState>(
        listener: (context, state) {
          if (state is PizzaLoadedState) {
            pizzas.addAll(state.pizzaList);
          }
          child:
          if (state is PizzaLoadingState) {
              const Center(
               child: CircularProgressIndicator(),
             );
          } else if (state is PizzaLoadedState) {
             RefreshIndicator(
              onRefresh: () async {
                pizzas = [];
                BlocProvider.of<PizzaBloc>(context).add(
                  PizzaLoadEvent(),
                );
              },
              child: ListView.builder(
                  itemCount: pizzas.length,
                  itemBuilder: (context, index) {
                    final pizza = pizzas[index];
                    return Container(
                      margin: const EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 20),
                      height: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 30,
                              offset: const Offset(10, 20),
                            )
                          ]),
                      child: Stack(children: <Widget>[
                        Center(
                          child: Row(
                            children: <Widget>[
                              Container(
                                // Картинка с пиццей
                                height: 90,
                                width: 90,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(getRandomPizzaImageFromAssets(),
                                    fit: BoxFit.fill),
                              ),
                              Container(
                                // Название пиццы
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    pizza.namePizza,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.lato().fontFamily,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // Цена пиццы
                          padding: const EdgeInsets.all(30),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "\$${pizza.pricePizza}",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.pink,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    );
                  }),
            );
          } else {
              const Center(
               child: Text('Произошла ошибка'),
             );
          }
        },
      ),
    );
  }

  String getRandomPizzaImageFromAssets() {
    Random random = Random();
    int numberPizza = random.nextInt(6);
    return "assets/image/pizza$numberPizza.png";
  }
}