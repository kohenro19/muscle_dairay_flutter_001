import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'note.dart';

class Notecard extends StatefulWidget {
  final String title;

  const Notecard({
    // required this.id,
    required this.title,
     Key? key }) : super(key: key);

  @override
  State<Notecard> createState() => _NotecardState();
}

class _NotecardState extends State<Notecard> {
  @override
  Widget build(BuildContext context) {

    // return Container(
    //       height: 130,
    //       width: MediaQuery.of(context).size.width-20,
    //       decoration: BoxDecoration(
    //         // image: AssetImage(),
    //         boxShadow: [
    //           BoxShadow(
    //             // blurRadius: 40,
    //             offset: Offset(8, 10)
    //           )
    //         ],
    //         color: Colors.red,
    //         borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(30),
    //           topLeft: Radius.circular(30),
    //           bottomRight: Radius.circular(30),
    //           bottomLeft: Radius.circular(30)
    //         )
    //       ),
    //     );
    return Container(
          // borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blueGrey,
                      child: Image.asset(
                        "images/chest.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10, right: 20, bottom: 30, left: 40),
                    Column(
                      children: <Widget>[
                        Container(
                        // color: Colors.blue,
                        width: 100,
                        child: Text("サイドレイズ"),
                      ),
                      Container(
                        child: Text("80kg"),
                      )
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