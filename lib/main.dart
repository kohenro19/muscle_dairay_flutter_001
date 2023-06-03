import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '筋トレダイアリー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
    List<Map> list = [
    {
      "time": "2020-06-16T10:31:12.000Z",
      "category": "肩"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "category": "大胸筋"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "category": "脚"
    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "category": "背中"
    },
    {
      "time": "2021-06-14T09:40:58.000Z",
      "category": "腹筋"
    }
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
                      itemCount: list.length,
            itemBuilder: (_, index) {
              bool isSameDate = true;
              final String dateString = list[index]['time'];
              final DateTime date = DateTime.parse(dateString); // DateTme型に変換
              final item = list[index];
              if (index == 0) {
                isSameDate = false;
              } else {
                final String prevDateString = list[index - 1]['time'];
                final DateTime prevDate = DateTime.parse(prevDateString);
                isSameDate = date.isSameDate(prevDate);
              }
              if (index == 0 || !(isSameDate)) {
                return Column(children: [
                  Text(date.formatDate()),
                  ListTile(title: Text(list[index]['category']))
                ]);
              } else {
                return ListTile(title: Text(list[index]['category']));
              }
            }
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

// extentionは、DateTimeクラスにメソッドを追加する
extension DateHelper on DateTime {
  
   String formatDate() {
     final formatter = DateFormat(dateFormatter);
      return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}