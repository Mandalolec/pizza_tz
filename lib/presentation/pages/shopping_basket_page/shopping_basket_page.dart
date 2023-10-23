import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/counter_purchase_bloc/counter_purchase_bloc.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_tz/presentation/pages/market_page/market_page.dart';

part 'widgets/list_purchase.dart';

part 'widgets/place_order.dart';

part 'widgets/shopping_basket_header.dart';

class ShoppingBasketPageWidget extends StatelessWidget {
  const ShoppingBasketPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ShoppingBasketHeaderWidget(),
            ),
            Expanded(
              flex: 6,
              child: ListPurchaseWidget(),
            ),
            Expanded(
              flex: 2,
              child: PlaceOrderWidget(),
            )
          ],
        ),
      ),
    );
  }
}
