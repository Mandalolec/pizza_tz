import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

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