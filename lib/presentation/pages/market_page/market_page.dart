import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_tz/presentation/pages/admin_page/admin_page.dart';
import 'package:pizza_tz/presentation/pages/shopping_basket_page/shopping_basket_page.dart';

part 'widgets/pizza_list.dart';

part 'widgets/market_header.dart';

part 'widgets/floating_buttons_with_sort_by_price_widget.dart';

class MarketPageWidget extends StatelessWidget {
  const MarketPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: MarketHeaderWidget(),
            ),
            Expanded(
              flex: 7,
              child: PizzaListWidget(),
            ),
            Expanded(
              flex: 1,
              child: FloatingButtonsWithSortByPriceWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

