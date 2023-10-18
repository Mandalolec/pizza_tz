import 'package:flutter/material.dart';
import 'package:pizza_tz/presentation/pages/market_page/pizza_list.dart';
import 'package:pizza_tz/presentation/pages/market_page/market_header.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

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