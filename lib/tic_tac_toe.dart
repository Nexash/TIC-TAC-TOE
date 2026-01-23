import 'dart:developer';

import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<bool> isclicked = List.generate(9, (_) => false);
  List<String?> values = List.generate(9, (_) => null);
  bool isZeroTurn = true;
  String? a = "";
  String? b = "";
  String? turn = "";
  String? winner;
  bool winnercheck = false;
  List<int> drawLine = List.generate(9, (index) => index); // all cells
  bool draw = false;
  List<int>? winningLine;
  bool gameStarted = false;

  List<List<int>> winningLines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void showSymbolDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose your symbol"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  a = "X";
                  b = "O";
                  turn = a;
                  gameStarted = true;
                });
                Navigator.pop(context);
              },
              child: const Text("X"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  a = "O";
                  b = "X";
                  turn = a;
                  gameStarted = true;
                });
                Navigator.pop(context);
              },
              child: const Text("O"),
            ),
          ],
        );
      },
    );
  }

  Widget displayResult() {
    if (winner != null) {
      return Center(
        child: Text(
          winnercheck ? "Congratulations $winner" : "",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    } else if (draw) {
      return Center(
        child: Text(
          draw ? "Its A Draw" : "",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return Text("");
  }

  // grid = ["0", "0", "0", null, "X", null, null, null, "X"]
  // line = [0,1,2]   // top row
  // grid[0] = "0"
  // grid[1] = "0"
  // grid[2] = "0"
  String? checkWinner(List<String?> grid, List<List<int>> lines) {
    for (var line in lines) {
      int a = line[0], b = line[1], c = line[2];
      if (grid[a] != null && grid[a] == grid[b] && grid[a] == grid[c]) {
        winningLine = line;
        log("$winningLine");
        log("${grid[a]} is the winner");
        winnercheck = true;
        return grid[a];
      }
    }
    log("Not Yet");
    return null;
  }

  void drawDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("DRAW"),
          content: Text("That was tough round!!!"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isclicked = List.generate(9, (_) => false);
                  values = List.generate(9, (_) => null);
                  winner = "";
                });
                Navigator.of(context).pop();
              },
              child: Center(child: Text("Play Again")),
            ),
          ],
        );
      },
    );
  }

  // void winnerDialogue() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("GAME OVER"),
  //         content: Text("$winner is the Winner !!!!"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 isclicked = List.generate(9, (_) => false);
  //                 values = List.generate(9, (_) => null);
  //                 winner = "";
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Center(child: Text("Play Again")),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBFC6C4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "TIC TAC TOE",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              Container(
                color: Color(0xFF41644A),
                height: 400,
                child:
                    gameStarted
                        ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                              ),
                          padding: EdgeInsets.all(20),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            Color textColor;
                            if (winningLine != null &&
                                winningLine!.contains(index) == true) {
                              textColor = Colors.red;
                            } else if (winner == null &&
                                values.every((v) => v != null)) {
                              textColor = Colors.blue;
                            } else {
                              textColor = Colors.black;
                            }
                            bool isClicked = isclicked[index];
                            String? value = values[index];
                            return ClipRRect(
                              child: Material(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromARGB(255, 147, 201, 159),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap:
                                      isclicked[index] ||
                                              winner !=
                                                  null //it gives false so null is not selected on second click the response is true so it selects null
                                          ? null
                                          : () {
                                            setState(() {
                                              values[index] =
                                                  isZeroTurn ? a : b;
                                              isZeroTurn = !isZeroTurn;
                                              isclicked[index] =
                                                  !isclicked[index];
                                              winner = checkWinner(
                                                values,
                                                winningLines,
                                              );
                                              turn = isZeroTurn ? a : b;
                                            });
                                            if (winner == null &&
                                                values.every(
                                                  (v) => v != null,
                                                )) {
                                              draw = true;
                                            }
                                          },
                                  child: Center(
                                    child: Text(
                                      isClicked ? "$value" : "",
                                      style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        : Center(
                          child: ElevatedButton(
                            onPressed: () => showSymbolDialog(),
                            child: Text("Start"),
                          ),
                        ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Text("Its turn :", style: TextStyle(fontSize: 30)),
                  SizedBox(width: 10),
                  Text("$turn ", style: TextStyle(fontSize: 30)),
                ],
              ),

              SizedBox(height: 20),
              displayResult(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isclicked = List.generate(9, (_) => false);
                    values = List.generate(9, (_) => null);
                    winner = null;
                    winningLine = [];
                    winnercheck = false;
                    draw = false;
                    turn = "";
                    a = "";
                    b = "";

                    gameStarted = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41644A),
                  fixedSize: Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Restart Gane",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
