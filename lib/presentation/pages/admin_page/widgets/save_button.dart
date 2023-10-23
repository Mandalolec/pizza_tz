part of '../admin_page.dart';


class SaveButtonWidget extends StatefulWidget {
  const SaveButtonWidget({super.key});

  @override
  State<SaveButtonWidget> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.pink),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: () {
          context.read<PizzaBloc>().add(
            AddPizzaInMarketEvent(),
          );
          context.read<PizzaBloc>().add(
            ClearAllPizzaMocksForMarketInAdminEvent(),
          );
        },
        child: Text(
          "Save",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}