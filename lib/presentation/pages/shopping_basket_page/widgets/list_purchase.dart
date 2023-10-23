part of '../shopping_basket_page.dart';

class ListPurchaseWidget extends StatefulWidget {
  const ListPurchaseWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListPurchaseState();
  }
}

class ListPurchaseState extends State<ListPurchaseWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzas =
    context.select((PizzaBloc bloc) => bloc.state.pizzasInBasket);
    return ListView.builder(
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        final pizza = pizzas[index];
        return Container(
          margin:
          const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
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
          child: Stack(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  // Картинка с пиццей
                  height: 90,
                  width: 90,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(getRandomPizzaImageFromAssets(),
                      fit: BoxFit.fill),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // Название пиццы
                      //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pizza.namePizza,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      // Цена пиццы
                      //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$${pizza.pricePizza}',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.pink,
                            fontFamily: GoogleFonts.lato().fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
            BlocProvider(
              create: (context) => CounterPurchaseBloc(pizza.countPizza)
                ..add(CounterInitEvent()),
              child: Container(
                // Counter
                padding: const EdgeInsets.all(30),
                alignment: Alignment.centerRight,
                child: BlocBuilder<CounterPurchaseBloc, CounterState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CounterPurchaseBloc>().add(
                              CounterDecrementEvent(),
                            );

                            if (state.count == 2) {
                              context.read<PizzaBloc>().add(
                                SetCountPizzaInBasket(1, index),
                              );
                            } else if (state.count > 2) {
                              context.read<PizzaBloc>().add(
                                SetCountPizzaInBasket(
                                    state.count - 1, index),
                              );
                            }
                            context.read<PizzaBloc>().add(
                              GetTotalAmountInBasket(),
                            );
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            size: 25,
                            color: (state.count > 1
                                ? Colors.redAccent
                                : Colors.grey),
                          ),
                        ),
                        Text(
                          state.count.toString(),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CounterPurchaseBloc>().add(
                              CounterIncrementEvent(),
                            );

                            context.read<PizzaBloc>().add(
                              SetCountPizzaInBasket(state.count + 1, index),
                            );

                            context.read<PizzaBloc>().add(
                              GetTotalAmountInBasket(),
                            );
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 25,
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}