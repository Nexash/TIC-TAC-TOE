import 'package:flutter/material.dart';
import 'package:tik_tac_toe/BestOfThree/logic.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  TicTacToeLogic logic = TicTacToeLogic();
  @override
  void initState() {
    super.initState();
    logic.onWinner = (winner) {
      winnerDialogue(winner);
    };
    logic.onDraw = () {
      drawDialogue();
    };
  }

  Widget displayResult() {
    if (logic.winner != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Congratulations ${logic.winner}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          logic.normalgameStarted || logic.infinitegameStarted
              ? SizedBox(width: 1)
              : ElevatedButton(
                onPressed: () {
                  logic.nextRound(() => setState(() {}));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41644A),
                  fixedSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Next Round",
                  style: TextStyle(color: Colors.white),
                ),
              ),
        ],
      );
    } else if (logic.draw) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              "Its A Draw",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          logic.normalgameStarted
              ? SizedBox(width: 1)
              : ElevatedButton(
                onPressed: () {
                  logic.nextRound(() => setState(() {}));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41644A),
                  fixedSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Next Round",
                  style: TextStyle(color: Colors.white),
                ),
              ),
        ],
      );
    }
    return SizedBox();
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
                  logic.dialogueHelper();
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
                  logic.dialogueHelper();
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
              Center(
                child: Text(
                  "TIC TAC TOE",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              logic.bO3gameStarted ||
                      logic.normalgameStarted ||
                      logic.infinitegameStarted
                  ? Row(
                    children: [
                      Text(
                        "Mode: ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      logic.normalgameStarted
                          ? Text(
                            "Show Down!!!",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : logic.bO3gameStarted
                          ? Text(
                            "Best Of THREE!!!",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : logic.infinitegameStarted
                          ? Text(
                            "Infinite Battle",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : Text(""),
                    ],
                  )
                  : Center(
                    child: Column(
                      children: [
                        Text(
                          "Choose the Mode",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

              logic.bO3gameStarted
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Player (X) - ${logic.xCount} ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${logic.oCount} - Player (O)  ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                  : SizedBox(height: 1),

              Center(
                child:
                    logic.bO3gameStarted
                        ? Column(
                          children: [
                            Text(
                              "Draw - ${logic.drawCount} ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                        : SizedBox(height: 1),
              ),

              Container(
                color: Color(0xFF41644A),
                height: 400,
                child:
                    logic.bO3gameStarted ||
                            logic.normalgameStarted ||
                            logic.infinitegameStarted
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
                            if (logic.winningLine != null &&
                                logic.winningLine!.contains(index) == true) {
                              textColor = Colors.red;
                            } else if (logic.winner == null &&
                                logic.values.every((v) => v != null)) {
                              textColor = Colors.blue;
                            } else {
                              textColor = Colors.black;
                            }
                            bool isClicked = logic.isclicked[index];
                            String? value = logic.values[index];
                            return ClipRRect(
                              child: Material(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromARGB(255, 147, 201, 159),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap:
                                      logic.winner != null ||
                                              logic.draw ||
                                              logic
                                                  .isFlickering //it gives false so null is not selected on second click the response is true so it selects null
                                          ? null
                                          : () {
                                            if (logic.values[index] != null) {
                                              return;
                                            }
                                            setState(() {
                                              logic.gridlogic(index);
                                            });
                                          },
                                  child: Center(
                                    child: AnimatedOpacity(
                                      opacity:
                                          logic.flickerIndex == index
                                              ? 0.2
                                              : 1.0, // flicker condition
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      child: Text(
                                        isClicked ? (value ?? "") : "",
                                        style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50),
                            Expanded(
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      147,
                                      201,
                                      159,
                                    ),
                                  ),
                                  onPressed:
                                      () => logic.shownormalSymbolDialog(
                                        () => setState(() {}),
                                        context,
                                      ),
                                  child: Text(
                                    "ShowDown",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Expanded(
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      147,
                                      201,
                                      159,
                                    ),
                                  ),
                                  onPressed:
                                      () => logic.showSymbolDialog(
                                        () => setState(() {}),
                                        context,
                                      ),
                                  child: Text(
                                    "Best of 3",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Expanded(
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      147,
                                      201,
                                      159,
                                    ),
                                  ),
                                  onPressed:
                                      () => logic.showInfiniteSymbolDialog(
                                        () => setState(() {}),
                                        context,
                                      ),

                                  child: Text(
                                    "Infinite",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
              ),

              SizedBox(height: 20),
              logic.normalgameStarted ||
                      logic.bO3gameStarted ||
                      logic.infinitegameStarted
                  ? Row(
                    children: [
                      Text("Its turn :", style: TextStyle(fontSize: 30)),

                      SizedBox(width: 10),
                      Text("${logic.turn} ", style: TextStyle(fontSize: 30)),
                    ],
                  )
                  : Text(""),

              displayResult(),
              SizedBox(height: 20),

              SizedBox(height: 10),
              logic.normalgameStarted ||
                      logic.bO3gameStarted ||
                      logic.infinitegameStarted
                  ? ElevatedButton(
                    onPressed: () {
                      logic.restartGame(() {
                        setState(() {});
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
                      "Choose mode",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                  : SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
