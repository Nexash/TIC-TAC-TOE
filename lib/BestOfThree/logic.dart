import 'dart:developer';

import 'package:flutter/material.dart';

class TicTacToeLogic {
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

  void nextRound(Function updateState) {
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
    updateState();
  }

  void restartGame(Function updateState) {
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
    updateState();
  }

  void Function()? onUpdate;

  void gridlogic(int index) {
    // If the cell is empty, normal click
    if (values[index] == null) {
      values[index] = isTurnOf ? player1 : player2;
      isclicked[index] = true;
      moveOrder.add(index);
      switchTurn ??= values[index];
    }

    isTurnOf = !isTurnOf;
    turn = isTurnOf ? player1 : player2;

    // // first move save to toggle later
    firstMove = firstMove ?? values[index];

    // Check winner
    winner = checkWinner(values, winningLines);
    // update points
    if (winner != null && !winnercheck) {
      updateWinnerCount();
      winnercheck = true;
    }

    // Check for draw (optional, though rolling grid may rarely be a draw)
    if (winner == null && values.every((v) => v != null)) {
      draw = true;
      drawCount++;
      updateWinnerCount();
    }
  }

  void Function(String)? onWinner;
  void Function()? onDraw;

  void updateWinnerCount() {
    if (winner == "X") {
      xCount++;
    } else if (winner == "O") {
      oCount++;
    }
    if (xCount == 2) {
      onWinner?.call("X");
    } else if (oCount == 2) {
      onWinner?.call("O");
    }
    if (drawCount == 3) {
      onDraw?.call();
    }
    if (xCount == 1 && oCount == 1 && drawCount == 1) {
      onDraw?.call();
    }
    if (drawCount == 2) {
      if (xCount == 0 && oCount == 1) {
        onWinner?.call("O");
      }
      if (oCount == 0 && xCount == 1) {
        onWinner?.call("X");
      }
    }
  }

  void showSymbolDialog(Function updateState, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose 1st player"),
          actions: [
            TextButton(
              onPressed: () {
                player1 = "X";
                player2 = "O";
                turn = player1;
                gameStarted = true;
                updateState();

                Navigator.pop(context);
              },
              child: const Text("X"),
            ),
            TextButton(
              onPressed: () {
                player1 = "O";
                player2 = "X";
                turn = player1;
                gameStarted = true;
                updateState();

                Navigator.pop(context);
              },
              child: const Text("O"),
            ),
          ],
        );
      },
    );
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

  void drawDialogueHelper() {
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
  }

  void winnerDialogueHelper() {
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
  }
}
