part of '../shopping_basket_page.dart';

class PlaceOrderWidget extends StatefulWidget {
  const PlaceOrderWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return PlaceOrderState();
  }
}

class PlaceOrderState extends State<PlaceOrderWidget> {
  @override
  Widget build(BuildContext context) {
    double totalAmount =
    context.select((PizzaBloc bloc) => bloc.state.totalAmount);
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$$totalAmount",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () =>
                    context.read<PizzaBloc>().add(ClearAllPizzasInBasket()),
                child: Text(
                  "Place my order",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}