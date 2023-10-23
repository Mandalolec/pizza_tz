
part of '../market_page.dart';

class MarketHeaderWidget extends StatefulWidget {
  const MarketHeaderWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return MarketHeaderWidgetState();
  }
}

class MarketHeaderWidgetState extends State<MarketHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Container(
              // Заголовок
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Pizza Market",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontWeight: FontWeight.bold),
              )),
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
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ShoppingBasketPageWidget(),
                        ),
                      );
                      context.read<PizzaBloc>().add(LoadPizzasInBasketEvent());
                      context.read<PizzaBloc>().add(GetTotalAmountInBasket());
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  iconSize: 26,
                  color: Colors.pink,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPage(),
                      ),
                    );
                    context.read<PizzaBloc>().add(GetPizzaMocksForMarketInAdminEvent());
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
