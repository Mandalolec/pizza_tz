import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_tz/domain/bloc/counter_purchase_bloc/counter_purchase_bloc.dart';
import 'package:pizza_tz/domain/bloc/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_tz/presentation/pages/market_page/market_page.dart';

part 'widgets/admin_header.dart';
part 'widgets/admin_list.dart';
part 'widgets/save_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: AdminHeaderWidget(),
            ),
            Expanded(
              flex: 7,
              child: AdminListWidget(),
            ),
            Expanded(
              flex: 1,
              child: SaveButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

