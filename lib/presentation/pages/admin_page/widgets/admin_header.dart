part of '../admin_page.dart';

class AdminHeaderWidget extends StatefulWidget {
  const AdminHeaderWidget({super.key});

  @override
  State<AdminHeaderWidget> createState() => _AdminHeaderState();
}

class _AdminHeaderState extends State<AdminHeaderWidget> {
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
              "Add pizza",
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.add_circle),
              iconSize: 30,
              color: Colors.pink,
              onPressed: () {
                context
                    .read<PizzaBloc>()
                    .add(AddPizzaMockForMarketInAdminEvent());
                context
                    .read<PizzaBloc>()
                    .add(GetPizzaMocksForMarketInAdminEvent());
              },
            ),
          ),
        ],
      ),
    );
  }
}