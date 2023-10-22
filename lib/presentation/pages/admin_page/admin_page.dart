import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
