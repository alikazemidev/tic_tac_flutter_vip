import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  Widget _getScorrBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'player O',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              scoreO.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'player X',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              scoreX.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getGridView() {
    return Expanded(
      child: GridView.builder(
        // shrinkWrap: true,
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              onTapped(index);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                    color: xOrOList[index] == 'O' ? Colors.red : Colors.blue,
                    fontSize: 51,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onTapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xOrOList[index] == 'X' || xOrOList[index] == 'O') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes += 1;
      } else {
        xOrOList[index] = 'X';
        filledBoxes += 1;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void checkWinner() {
    // *horizantal
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ' + xOrOList[0]);

      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], 'winner is ' + xOrOList[3]);
      return;
    }

    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], 'winner is ' + xOrOList[6]);
      return;
    }

    // *vertical
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ' + xOrOList[0]);
      return;
    }

    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], 'winner is ' + xOrOList[1]);
      return;
    }

    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ' + xOrOList[2]);
      return;
    }

    // *z axis
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ' + xOrOList[2]);
      return;
    }

    if (filledBoxes == 9) {
      setResult('', 'game draw');
    }
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void clearGame() {
    setState(
      () {
        for (int i = 0; i < xOrOList.length; i++) {
          xOrOList[i] = '';
        }
      },
    );
    filledBoxes = 0;
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      if (winner == 'X') {
        scoreX += 1;
        winnerTitle = title;
      } else if (winner == 'O') {
        scoreO += 1;
        winnerTitle = title;
      } else {
        scoreX += 1;
        scoreO += 1;
        winnerTitle = title;
      }
    });
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle play again',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        centerTitle: true,
        title: Text('TicTacToe'),
        actions: [
          IconButton(
              onPressed: clearGame,
              icon: Icon(
                Icons.refresh,
              ))
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            _getScorrBoard(),
            SizedBox(height: 20),
            getResultButton(),
            SizedBox(height: 20),
            _getGridView(),
            _getTurn(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
