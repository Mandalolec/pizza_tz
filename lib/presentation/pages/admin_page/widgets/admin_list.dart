part of '../admin_page.dart';

class AdminListWidget extends StatefulWidget {
  const AdminListWidget({super.key});

  @override
  State<AdminListWidget> createState() => _AdminListState();
}

class _AdminListState extends State<AdminListWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzas = context.select(
          (PizzaBloc bloc) => bloc.state.pizzaInAdmin,
    );
    return ListView.builder(
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        var nameController = TextEditingController();
        var priceController = TextEditingController();
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
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      // Картинка с пиццей
                      height: 90,
                      width: 90,
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(getRandomPizzaImageFromAssets(),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 150,
                            child: Container(
                              // Название пиццы
                              //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: nameController,
                                enabled: true,
                                onChanged: (name) {
                                  context.read<PizzaBloc>().add(
                                    SetNameOnPizzaMockInAdminEvent(
                                      name,
                                      index,
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Name',
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    onPressed: nameController.clear,
                                  ),
                                ),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 150,
                            child: Container(
                              // Цена пиццы
                              //padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: priceController,
                                enabled: true,
                                onChanged: (price) {
                                  context.read<PizzaBloc>().add(
                                    SetPriceOnPizzaMockInAdminEvent(
                                      price,
                                      index,
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Price',
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    onPressed: priceController.clear,
                                  ),
                                ),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              context.read<PizzaBloc>().add(
                                SetCountPizzaMockForMarketInAdminEvent(
                                  state.count,
                                  index,
                                ),
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
                                SetCountPizzaMockForMarketInAdminEvent(
                                  state.count,
                                  index,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              size: 25,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}