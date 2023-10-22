import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/counter_purchase_bloc/counter_purchase_bloc.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';

class ShoppingBasketPageWidget extends StatelessWidget {
  const ShoppingBasketPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(flex: 1, child: ShoppingBasketHeaderWidget()),
              Expanded(
                flex: 6,
                child: ListPurchaseWidget(),
              ),
              Expanded(flex: 2, child: PlaceOrderWidget())
            ],
          ),
        ));
  }
}

class ShoppingBasketHeaderWidget extends StatefulWidget {
  const ShoppingBasketHeaderWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShoppingBasketHeaderWidgetState();
  }
}

class ShoppingBasketHeaderWidgetState
    extends State<ShoppingBasketHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              padding: const EdgeInsets.only(left: 10),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 30, color: Colors.pink),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              "Order details",
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class PlaceOrderWidget extends StatefulWidget {
  const PlaceOrderWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return PlaceOrderState();
  }
}

class PlaceOrderState extends State<PlaceOrderWidget> {
  @override
  Widget build(BuildContext context) {
    double totalAmount =
        context.select((PizzaBloc bloc) => bloc.state.totalAmount);
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$$totalAmount",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () =>
                      context.read<PizzaBloc>().add(GetTotalAmountInBasket()),
                  child: Text(
                    "Place my order",
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class ListPurchaseWidget extends StatefulWidget {
  const ListPurchaseWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPurchaseState();
  }
}

class ListPurchaseState extends State<ListPurchaseWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzas =
        context.select((PizzaBloc bloc) => bloc.state.pizzasInBasket);
    return ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
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
                            pizza.namePizza,
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
                          '\$${pizza.pricePizza}',
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
                create: (context) => CounterPurchaseBloc(pizza.countPizza)
                  ..add(CounterInitEvent()),
                child: Container(
                  // Counter
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<CounterPurchaseBloc, CounterState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CounterPurchaseBloc>().add(
                                    CounterDecrementEvent(),
                                  );

                              if (state.count == 2) {
                                context.read<PizzaBloc>().add(
                                      SetCountPizzaInBasket(1, index),
                                    );
                              } else if (state.count > 2){
                                context.read<PizzaBloc>().add(
                                      SetCountPizzaInBasket(
                                          state.count - 1, index),
                                    );
                              }
                              context.read<PizzaBloc>().add(
                                    GetTotalAmountInBasket(),
                                  );
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              size: 30,
                              color: (state.count > 1
                                  ? Colors.redAccent
                                  : Colors.grey),
                            ),
                          ),
                          Text(
                            state.count.toString(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.pink,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CounterPurchaseBloc>().add(
                                    CounterIncrementEvent(),
                                  );

                              context.read<PizzaBloc>().add(
                                    SetCountPizzaInBasket(
                                        state.count + 1, index),
                                  );

                              context.read<PizzaBloc>().add(
                                    GetTotalAmountInBasket(),
                                  );
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Colors.redAccent,
                            ),
                          )
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

  String getRandomPizzaImageFromAssets() {
    Random random = Random();
    int numberPizza = random.nextInt(6);
    return "assets/image/pizza$numberPizza.png";
  }
}
