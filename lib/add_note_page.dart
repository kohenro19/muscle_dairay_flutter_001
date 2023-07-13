import 'package:flutter/material.dart';
import 'package:muscle_dairay/db_provider.dart';
import 'package:muscle_dairay/Note.dart';
import 'package:numberpicker/numberpicker.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

    Map<String, List<String>> _dropDownMenu = {
    '肩': ['サイドレイズ', 'ショルダープレス',],
    '大胸筋': ['ベンチプレス'],
    '大腿': ['スクワット']
  };

   String? _selectedCategory;  // ?はnullになってもいい記号
   String? _selectedItem;
   int _currentValue = 50;

  final dbProvider = DBProvider();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector( // leadingは、戻りの矢印
        onTap: () {Navigator.pop(context);}, // 前のページに戻るときはpopを使う
        child: Icon(Icons.arrow_back, color: Colors.white)
      ),
      title: const Text('Muscle Diary',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '部位は？',
                style: TextStyle(fontSize: 24),
              ),
              DropdownButton<String>(
                value: _selectedCategory,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),

                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!; // !はnullじゃないと確定する記号
                    _selectedItem = _dropDownMenu[_selectedCategory]![0];
                  });
                },
                items: _dropDownMenu.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          _selectedCategory != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '種目は?',
                      style: TextStyle(fontSize: 24),
                    ),
                    DropdownButton<String>(
                      value: _selectedItem,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                        });
                      },
                      items: _dropDownMenu[_selectedCategory]
                          ?.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )
              : Container(),
              NumberPicker(
                value: _currentValue,
                minValue: 0,
                maxValue: 100,
                onChanged: (value) => setState(() => _currentValue = value),
                    ),
              Text('Current value: $_currentValue'),
        Container(
          child: ElevatedButton(
            child: Text('記録'),
            onPressed: () async {
              dbProvider.addNote(Note(
                date: DateTime(2023, 07, 15, 0, 0).toString(), // 今日の日付を入れる
                category: _selectedCategory!,
                exercise: _selectedItem!,
                weight: _currentValue
              ));

            },


          ),
        )
        ],
      ),
    
    );
  
    
  }
}