import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: MarketHeader(),
            ),
            Expanded(
                flex: 9,
                child: PizzaList()
            )
          ],
        )
      )
    );
  }
}

class MarketHeader extends StatefulWidget {
  const MarketHeader({super.key});

  @override
  State<StatefulWidget> createState() {
    return MarketHeaderWidget();
  }
}

class MarketHeaderWidget extends State<MarketHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget> [
          Container(
            // Заголовок
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Pizza Market",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                Container(
                  // Иконка-кнопка корзины
                  padding: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    iconSize: 26,
                    onPressed: () {},
                  ),
                ),
                Container(
                  // Иконка-кнопка админки
                  child: IconButton(
                    icon: const Icon(Icons.person),
                    iconSize: 26,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

class PizzaList extends StatefulWidget {
  const PizzaList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPizzaWidget();
  }
}

class ListPizzaWidget extends State<PizzaList> {
  List<String> pizzas = getPizzaList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
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
                ]
            ),
            child: Stack(
              children: <Widget> [
                Center(
                  child: Row(
                    children: <Widget>[
                      Container(
                        // Картинка с пиццей
                        height: 90,
                        width: 90,
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                            getRandomPizzaImageFromAssets(),
                            fit: BoxFit.fill
                        ),
                      ),
                      Container(
                        // Название пиццы
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Pepperoni",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                    ],
                  ),
                ),

                Container(
                  // Цена пиццы
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "\$20",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.pink,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ]
            ),
          );
        }
    );
  }


  static List<String> getPizzaList() {
    List<String> pizzas = List.generate(10, (index) => "Pizza ${index + 1}");
    return pizzas;
  }

  String getRandomPizzaImageFromAssets() {
    Random random = Random();
    int numberPizza = random.nextInt(6);
    return "assets/image/pizza$numberPizza.png";
  }
}

