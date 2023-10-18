import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_tz/domain/bloc/counter_purchase_cubit/counter_purchase_cubit.dart';
import 'package:pizza_tz/domain/models/pizza.dart';


class ShoppingBasketPage extends StatelessWidget {
  const ShoppingBasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListPurchase(),
        ));
  }
}

class ListPurchase extends StatefulWidget {
  const ListPurchase({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPurchaseWidget();
  }
}

class ListPurchaseWidget extends State<ListPurchase> {
  final List<Pizza> _purchase = getPurchaseList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _purchase.length,
        itemBuilder: (context, index) {
          return Container(
            margin:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
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
              Row(
                children: <Widget>[
                  Container(
                    // Картинка с пиццей
                    height: 90,
                    width: 90,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(getRandomPizzaImageFromAssets(),
                        fit: BoxFit.fill),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          // Название пиццы
                          //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _purchase[index].namePizza,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        // Цена пиццы
                        //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _purchase[index].pricePizza,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.pink,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              BlocProvider(
                create: (context) => CounterPurchaseCubit(),
                child: Container(
                  // Counter
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<CounterPurchaseCubit, int>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () => context
                                  .read<CounterPurchaseCubit>()
                                  .decrement(),
                              icon: Icon(
                                Icons.remove_circle,
                                size: 30,
                                color: (state > 1 ? Colors.redAccent : Colors.grey),
                              )),
                          Text(
                            state.toString(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.pink,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () => context
                                  .read<CounterPurchaseCubit>()
                                  .increment(),
                              icon: const Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Colors.redAccent,
                              ))
                        ],
                      );
                    },
                  ),
                ),
              )
            ]),
          );
        });
  }

  IconButton getRemoveIcon(int counter) {
    if (counter != 0) {
      return IconButton(
          onPressed: () => context.read<CounterPurchaseCubit>().decrement(),
          icon: const Icon(
            Icons.remove_circle,
            size: 30,
            color: Colors.redAccent,
          ));
    } else {
      return IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.remove_circle,
            size: 30,
            color: Colors.grey,
          ));
    }
  }

  static List<Pizza> getPurchaseList() {
    List<Pizza> purchase = [
      Pizza(
          idPizza: 1, namePizza: "Pizaras", pricePizza: "\$20", countPizza: 1),
      Pizza(
          idPizza: 2, namePizza: "Pepperoni", pricePizza: "\$30", countPizza: 2)
    ];
    return purchase;
  }

  String getRandomPizzaImageFromAssets() {
    Random random = Random();
    int numberPizza = random.nextInt(6);
    return "assets/image/pizza$numberPizza.png";
  }
}
