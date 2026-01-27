import 'package:flutter/material.dart';
import 'package:tik_tac_toe/BestOfThree/logic.dart';
import 'package:tik_tac_toe/enum.dart';

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
                          : SizedBox.shrink(),
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
              SizedBox(height: 20),

              logic.bO3gameStarted
                  ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 71, 155, 92),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Player (X) - ${logic.xCount} ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Player (O) - ${logic.oCount}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Draw - ${logic.drawCount} ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          logic.normalgameStarted ||
                                  logic.bO3gameStarted ||
                                  logic.infinitegameStarted
                              ? Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 147, 201, 159),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Turn",
                                        style: TextStyle(fontSize: 27),
                                      ),

                                      SizedBox(width: 5),
                                      Text(
                                        "${logic.turn} ",
                                        style: TextStyle(fontSize: 27),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 71, 155, 92), // put color here
                  borderRadius: BorderRadius.circular(40), // border radius
                ),
                height: 380,
                child:
                    logic.bO3gameStarted ||
                            logic.normalgameStarted ||
                            logic.infinitegameStarted
                        ? GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
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
                                              logic
                                                  .draw //it gives false so null is not selected on second click the response is true so it selects null
                                          ? null
                                          : () {
                                            if (logic.values[index] != null) {
                                              return;
                                            }

                                            logic.gridlogic(
                                              index,
                                              () => setState(() {}),
                                            );
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
                                        Modepassing.showDown,
                                      ),
                                  child: Text(
                                    "Show Down",
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
                                      () => logic.shownormalSymbolDialog(
                                        () => setState(() {}),
                                        context,
                                        Modepassing.bo3,
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
                                      () => logic.shownormalSymbolDialog(
                                        () => setState(() {}),
                                        context,
                                        Modepassing.infinite,
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
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
