part of '../market_page.dart';

class PizzaListWidget extends StatefulWidget {
  const PizzaListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPizzaState();
  }
}

class ListPizzaState extends State<PizzaListWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzas =
        context.select((PizzaBloc bloc) => bloc.state.pizzasInMarket);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Поиск по имени',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              context.read<PizzaBloc>().add(
                    SearchPizza(query),
                  );
              if (query.isEmpty) {
                context.read<PizzaBloc>().add(
                      LoadPizzasInMarketEvent(),
                    );
              }
            },
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemCount: pizzas.length,
            itemBuilder: (context, index) {
              final pizza = pizzas[index];
              return GestureDetector(
                onTap: () {
                  final pizzaBloc = context.read<PizzaBloc>();
                  pizzaBloc.add(AddPizzaInBasketEvent(index));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 20),
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
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
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
                                  fit: BoxFit.fill),
                            ),
                            Container(
                              // Название пиццы
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                pizza.namePizza,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // Цена пиццы
                        padding: const EdgeInsets.all(30),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "\$${pizza.pricePizza}",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.pink,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String getRandomPizzaImageFromAssets() {
  Random random = Random();
  int numberPizza = random.nextInt(6);
  return "assets/image/pizza$numberPizza.png";
}
