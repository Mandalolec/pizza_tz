part of '../market_page.dart';


class FloatingButtonsWithSortByPriceWidget extends StatefulWidget {
  const FloatingButtonsWithSortByPriceWidget({super.key});

  @override
  State<FloatingButtonsWithSortByPriceWidget> createState() =>
      _FloatingButtonsWithSortByPriceState();
}

class _FloatingButtonsWithSortByPriceState
    extends State<FloatingButtonsWithSortByPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: () {
              context.read<PizzaBloc>().add(
                SortByPriceASC(),
              );
              context.read<PizzaBloc>().add(
                LoadPizzasInMarketEvent(),
              );
            },
            child: const Icon(
              Icons.arrow_upward,
              size: 18,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: () {
              context.read<PizzaBloc>().add(
                SortByPriceDESC(),
              );
              context.read<PizzaBloc>().add(
                LoadPizzasInMarketEvent(),
              );
            },
            child: const Icon(
              Icons.arrow_downward,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}