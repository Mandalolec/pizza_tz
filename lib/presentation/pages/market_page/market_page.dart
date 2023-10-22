import 'package:flutter/material.dart';
import 'package:pizza_tz/presentation/pages/market_page/widgets/pizza_list.dart';
import 'package:pizza_tz/presentation/pages/market_page/widgets/market_header.dart';

class MarketPageWidget extends StatelessWidget {
  const MarketPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: MarketHeaderWidget(),
                ),
                Expanded(
                    flex: 9,
                    child: PizzaListWidget()
                )
              ],
            )
        )
    );
  }
}