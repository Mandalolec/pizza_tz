part of '../shopping_basket_page.dart';

class ShoppingBasketHeaderWidget extends StatefulWidget {
  const ShoppingBasketHeaderWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShoppingBasketHeaderWidgetState();
  }
}

class ShoppingBasketHeaderWidgetState
    extends State<ShoppingBasketHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              padding: const EdgeInsets.only(left: 10),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 30, color: Colors.pink),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              "Order details",
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}