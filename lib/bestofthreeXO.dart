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
  List<int> moveOrder = []; // stores indexes in the order they were clicked

  bool isTurnOf = true;
  String? player1 = "";
  String? player2 = "";
  String? switchTurn;
  String? turn = "";
  String? winner;
  String? firstMove;

  bool winnercheck = false;
  int xCount = 0;
  int oCount = 0;
  int drawCount = 0;

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

  void updateWinnerCount() {
    if (winner == "X") {
      xCount++;
    } else if (winner == "O") {
      oCount++;
    }
    if (xCount == 2) {
      winnerDialogue("X");
    } else if (oCount == 2) {
      winnerDialogue("O");
    }
    if (drawCount == 3) {
      drawDialogue();
    }
    if (xCount == 1 && oCount == 1 && drawCount == 1) {
      drawDialogue();
    }
    if (drawCount == 2) {
      if (xCount == 0 && oCount == 1) {
        winnerDialogue("O");
      }
      if (oCount == 0 && xCount == 1) {
        winnerDialogue("X");
      }
    }
  }

  void showSymbolDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose 1st player"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  player1 = "X";
                  player2 = "O";
                  turn = player1;
                  gameStarted = true;
                });
                Navigator.pop(context);
              },
              child: const Text("X"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  player1 = "O";
                  player2 = "X";
                  turn = player1;
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
          "Congratulations $winner",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    } else if (draw) {
      return Center(
        child: Text(
          "Its A Draw",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return SizedBox();
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
        // winnercheck = true;
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
                  winner = null;
                  moveOrder.clear();
                  winningLine = [];
                  winnercheck = false;
                  draw = false;
                  turn = "";
                  player1 = "";
                  player2 = "";
                  isTurnOf = true;
                  gameStarted = false;
                  xCount = 0;
                  oCount = 0;
                  drawCount = 0;
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

  void winnerDialogue(String win) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("GAME OVER"),
          content: Text("$win is the Winner !!!!"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isclicked = List.generate(9, (_) => false);
                  values = List.generate(9, (_) => null);
                  winner = null;
                  moveOrder.clear();
                  winningLine = [];
                  winnercheck = false;
                  draw = false;
                  turn = "";
                  drawCount = 0;
                  player1 = "";
                  player2 = "";
                  isTurnOf = true;
                  gameStarted = false;
                  xCount = 0;
                  oCount = 0;
                });
                Navigator.pop(context);
              },
              child: Center(child: Text("Play Again")),
            ),
          ],
        );
      },
    );
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Player (X) - $xCount ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$oCount - Player (O)  ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Center(
                child: Text(
                  "Draw - $drawCount ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
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
                                      winner != null ||
                                              draw //it gives false so null is not selected on second click the response is true so it selects null
                                          ? null
                                          : () {
                                            if (values[index] != null) {
                                              return;
                                            }
                                            setState(() {
                                              // If the cell is empty, normal click
                                              if (values[index] == null) {
                                                values[index] =
                                                    isTurnOf
                                                        ? player1
                                                        : player2;
                                                isclicked[index] = true;
                                                moveOrder.add(index);
                                                switchTurn ??= values[index];
                                              }

                                              isTurnOf = !isTurnOf;
                                              turn =
                                                  isTurnOf ? player1 : player2;

                                              // // first move save to toggle later
                                              firstMove =
                                                  firstMove ?? values[index];

                                              // Check winner
                                              winner = checkWinner(
                                                values,
                                                winningLines,
                                              );
                                              // update points
                                              if (winner != null &&
                                                  !winnercheck) {
                                                updateWinnerCount();
                                                winnercheck = true;
                                              }

                                              // Check for draw (optional, though rolling grid may rarely be a draw)
                                              if (winner == null &&
                                                  values.every(
                                                    (v) => v != null,
                                                  )) {
                                                draw = true;
                                                drawCount++;
                                                updateWinnerCount();
                                              }
                                            });
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

              displayResult(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // here we clear the board
                    isclicked = List.generate(9, (_) => false);
                    values = List.generate(9, (_) => null);
                    moveOrder.clear();
                    winner = null;
                    winningLine = [];
                    winnercheck = false;
                    draw = false;

                    // Decide who starts next round based on last roundStarter
                    if (switchTurn == player1) {
                      // If player1 started last round, player2 starts this round
                      isTurnOf = false;
                      turn = player2;
                    } else {
                      // If player2 started last round, player1 starts this round
                      isTurnOf = true;
                      turn = player1;
                    }
                    switchTurn = null;

                    // gameStarted = true;
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
                  "Next Round",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isclicked = List.generate(9, (_) => false);
                    values = List.generate(9, (_) => null);
                    winner = null;
                    moveOrder.clear();
                    winningLine = [];
                    winnercheck = false;
                    draw = false;
                    turn = "";
                    player1 = "";
                    player2 = "";
                    isTurnOf = true;
                    gameStarted = false;
                    xCount = 0;
                    drawCount = 0;
                    oCount = 0;
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
                  "Restart Game",
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
