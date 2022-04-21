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
  bool gameOver = false;

  bool _showListNotEmpty() {
    gameOver = xOrOList.every((element) => element.length > 0);
    if (gameOver) {
      print('ali');
    }
    return gameOver;
  }

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
              'O',
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
              '1',
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
              onTapped(index, context);
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

  void onTapped(int index, BuildContext context) {
    setState(() {
      if (xOrOList[index] == 'X' || xOrOList[index] == 'O') {
        return;
      }

      if (isTurnO) {
        xOrOList[index] = 'O';
      } else {
        xOrOList[index] = 'X';
      }
      isTurnO = !isTurnO;
    });
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

  @override
  Widget build(BuildContext context) {
    print(xOrOList);
    _showListNotEmpty();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        centerTitle: true,
        title: Text('TicTacToe'),
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            _getScorrBoard(),
            SizedBox(height: 40),
            _getGridView(),
            _getTurn(),
          ],
        ),
      ),
    );
  }
}
