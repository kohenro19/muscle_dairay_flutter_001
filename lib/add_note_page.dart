import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

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
      body: Center(child: Text("Muscle Diary")),
    );
    
  }
}