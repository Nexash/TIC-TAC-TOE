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
      return logic.bO3gameStarted
          ? SizedBox.shrink()
          : Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "Congratulations ${logic.winner}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(213, 255, 255, 255),
              ),
            ),
          );
    } else if (logic.draw) {
      return logic.bO3gameStarted
          ? SizedBox.shrink()
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Center(
                  child: Text(
                    "Its A Draw",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(213, 255, 255, 255),
                    ),
                  ),
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
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color.fromARGB(226, 255, 255, 255),
          title: Center(child: Text(" It's a DRAW")),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Score:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Player (X) - ${logic.xCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Player (O) - ${logic.oCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Draw - ${logic.drawCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  logic.dialogueHelper();
                });

                Navigator.of(context).pop();
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF41644A),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Text(
                      "Play Again",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void winnerDialogue(String win) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color.fromARGB(226, 255, 255, 255),
          title: Center(child: Text("$win is the Winner !!!!")),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Score:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Player (X) - ${logic.xCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Player (O) - ${logic.oCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Draw - ${logic.drawCount}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  logic.dialogueHelper();
                });

                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF41644A),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Text(
                      "Play Again",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
            mainAxisAlignment: MainAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child:
                    logic.bO3gameStarted ||
                            logic.normalgameStarted ||
                            logic.infinitegameStarted
                        ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                            Center(
                              child:
                                  logic.normalgameStarted
                                      ? Text(
                                        "Show Down!!!",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                      : logic.bO3gameStarted
                                      ? Text(
                                        "Best Of THREE!!!",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                      : logic.infinitegameStarted
                                      ? Text(
                                        "Infinite Battle",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                      : SizedBox.shrink(),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Center(
                              child: Text(
                                "TIC TAC TOE",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              logic.bO3gameStarted ||
                      logic.normalgameStarted ||
                      logic.infinitegameStarted
                  ? Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 71, 155, 92),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                          logic.bO3gameStarted
                              ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${logic.xCount} - Player (X)",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                        255,
                                        222,
                                        219,
                                        219,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${logic.oCount} - Player (O)",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                        255,
                                        222,
                                        219,
                                        219,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${logic.drawCount} - Draw",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                        255,
                                        222,
                                        219,
                                        219,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [displayResult()],
                              ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 71, 155, 92), // put color here
                    borderRadius: BorderRadius.circular(20), // border radius
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
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
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(
                                    255,
                                    147,
                                    201,
                                    159,
                                  ),
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
                              SizedBox(height: 20),
                              Text(
                                "GAME MODES",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 216, 222, 219),
                                ),
                              ),
                              SizedBox(height: 10),
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
                                        color: Color.fromARGB(255, 1, 17, 9),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
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
                              SizedBox(height: 10),
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
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              logic.normalgameStarted || logic.infinitegameStarted
                  ? SizedBox(width: 1)
                  : logic.bO3gameStarted
                  ? ElevatedButton(
                    onPressed: () {
                      logic.nextRound(() => setState(() {}));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF41644A),
                      fixedSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Next Round",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                  : SizedBox.shrink(),

              SizedBox(height: 10),
              logic.normalgameStarted ||
                      logic.bO3gameStarted ||
                      logic.infinitegameStarted
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              logic.dialogueHelper();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF41644A),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            logic.restartGame(() {
                              setState(() {});
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF41644A),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Choose mode",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
