import 'package:flutter/material.dart';
import 'package:tik_tac_toe/BestOfThree/bestofthreeXO.dart';
import 'package:tik_tac_toe/normalXO.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NormalTicTacToe()),
              );
            },
            child: Text("Normal TIC TAC TOE"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicTacToe()),
              );
            },
            child: Text("Best of 3. \nTIC TAC TOE"),
          ),
        ],
      ),
    );
  }
}
