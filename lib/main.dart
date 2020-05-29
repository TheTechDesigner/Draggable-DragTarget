import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Draggable / DragTarget';

  int _counter = 0;
  List<Color> _colors = [
    Color(0xFFC41A3B), //0
    Color(0xFF1B1F32), //1
    Color(0xFFFBE0E6), //2
  ];

  Color _newColor = Color(0xFFC41A3B);
  Color _currentColor = Color(0xFF1B1F32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Draggable<String>(
                data: _newColor.toString(),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  color: _newColor,
                ),
                feedback: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: _newColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 16.0,
                        offset: Offset(0.0, 4.0),
                        color: Colors.black.withOpacity(0.28),
                      ),
                    ],
                  ),
                ),
                childWhenDragging: Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.grey,
                ),
                onDragCompleted: () {
                  if (_counter < 2) {
                    _counter++;
                  } else {
                    _counter = 0;
                  }
                  setState(() {
                    _newColor = _colors[_counter];
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: DragTarget<String>(
              builder: (context, accepted, rejected) {
                return Container(
                  color: _currentColor,
                );
              },
              onWillAccept: (data) {
                if(data == Color(0xFFC41A3B).toString()) {
                  return true;
                }
                return true; 
              },
              onAccept: (data) {
                setState(() {
                  _currentColor = _newColor;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
