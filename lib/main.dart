import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscle_dairay/add_note_page.dart';
import 'note_card.dart';
import 'db_provider.dart';
import 'package:muscle_dairay/Note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muscle Diary',
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
        textTheme: GoogleFonts.firaSansCondensedTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      home: const MyHomePage(title: 'Muscle Diary'),
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
  final dbProvider = DBProvider();

  @override
  void initState() {  // アプリ起動時に最新のお気に入り状態を表示する為に、initStateを実装
    super.initState();
    // dbProvider._initDatabase(); // _が先頭につくと、外部参照不可なのでエラーが出る
    dbProvider.getNotes();  // データを更新するメソッドを呼び出す
  }

    List<Map> list = [
    {
      "time": "2020-06-16T10:31:12.000Z",
      "category": "肩",
      "exercise": "サイドレイズ",
      "weight": 12
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "category": "大胸筋",
      "exercise": "ベンチプレス",
      "weight": 90

    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "category": "脚",
      "exercise": "レッグエクステンション",
      "weight": 30

    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "category": "背中",
      "exercise": "ラットプルダウン",
      "weight": 45
    },
    {
      "time": "2021-06-14T09:40:58.000Z",
      "category": "腹筋",
      "exercise": "シットアップ",
      "weight": 10
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // タイトルを中央揃えにする
        title: Text(widget.title, 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
      ),
      body: Center(
        child: FutureBuilder<List<Note>>(
          future: dbProvider.getNotes(),
          initialData: [],
          builder: (BuildContext context, snapshot) {
            var data = snapshot.data;
            var datalength = data!.length; // !はnullではない事を意味する

           return datalength == 0

           ? const Center(
              child: Text('記録がありません'),
           )
           : ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  bool isSameDate = true;
                  final String dateString = data[index]['time'];
                  final DateTime date = DateTime.parse(dateString); // DateTme型に変換
                  final item = data[index];
                  if (index == 0) {
                    isSameDate = false;
                  } else {
                    final String prevDateString = data[index - 1]['time'];
                    final DateTime prevDate = DateTime.parse(prevDateString);
                    isSameDate = date.isSameDate(prevDate);
                  }
                  if (index == 0 || !(isSameDate)) {
                    return Padding(
                      padding: EdgeInsets.all(2), // 隣のColumnとの間に余白を付ける
                      child: Column(children: [
                        Text(date.formatDate()),
                        Dismissible(
                          key: Key(list[index].toString()), 
                          child: Notecard(title: list[index]['category'].toString()),
                          direction: DismissDirection.horizontal,
                        )
                      ]),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(2), // 隣のColumnとの間に余白を付ける
                      child: Column(children: [ // Columnがないと横幅が広がる
                        Dismissible(
                          key:Key(list[index].toString()),
                          child: Notecard(title: list[index]['category'].toString()),
                          direction: DismissDirection.horizontal,
                        )
                      ]),
                    );
                    
                  }
                }
            );
          }
          ),
        ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute<bool>(
              builder: (context) => AddNote()
            )
          ).then((value) {   // thenがないと即時反映されない
            setState(() {});
          });    
          },
          tooltip: 'Add Note',
          child: const Icon(Icons.add),
        ),
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
    // 151行目のthis.yearは、112行目で定義されたDateTimeオブジェクトdateと関連している
    // thisは現在のインスタンス自体を指す
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}