import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muscle_dairay/Note.dart';
import 'note.dart';
import 'package:google_fonts/google_fonts.dart';


class Notecard extends StatefulWidget {
  final String category;
  final String exercise;
  final int weight;

  const Notecard({
    // required this.id,
    required this.category,
    required this.exercise,
    required this.weight,

     Key? key }) : super(key: key);

  @override
  State<Notecard> createState() => _NotecardState();
}

class _NotecardState extends State<Notecard> {
  @override
  Widget build(BuildContext context) {

    return Container(
          // borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width-2,
        height: 80,
        // color: Colors.red,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFd8dbe0),
              offset: Offset(1, 1),
              blurRadius: 20.0,
              spreadRadius: 10
              // 
              )
            
          ]

        ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      child: Text(widget.category),
                    ),
                    SizedBox(width: 30),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10, right: 20, bottom: 30, left: 40),
                    Row(
                      children: <Widget>[
                        Container(
                        // color: Colors.blue,
                        width: 120,
                        child: Text(widget.exercise,
                          style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      Container(
                        child: Text(widget.weight.toString()+"kg", style: TextStyle(fontSize: 18),),
                      ),
                      SizedBox(width: 40),
                      IconButton(onPressed: () {
            // アイコンが押されたときの処理
            print('Icon Pressed');
          }, icon: Icon(Icons.edit_outlined))
                      ]
                    ),
                    
                  // )
                  ]
                ),

              ]
            ),
          
        );
  }

}