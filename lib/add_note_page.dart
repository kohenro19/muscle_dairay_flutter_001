import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

    Map<String, List<String>> _dropDownMenu = {
    'Study': ['Math', 'Englsih', 'Japanese'],
    'Workout': ['Shoulder', 'Chest', 'Back'],
    'Coding': ['Flutter', 'Python', 'C#']
  };

   String? _selectedKey;
   String? _selectedItem;
  //  late String newValue;

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
                'What did you do?',
                style: TextStyle(fontSize: 24),
              ),
              DropdownButton<String>(
                value: _selectedKey,
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
                    _selectedKey = newValue!;
                    _selectedItem = _dropDownMenu[_selectedKey]![0];
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
          _selectedKey != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Which one?',
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
                      items: _dropDownMenu[_selectedKey]
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
        ],
      ),
    );
  
    
  }
}