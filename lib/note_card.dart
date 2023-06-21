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
    return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blueGrey,
                      child: Image.asset(
                        "images/happiness.jpg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  Text("80 kg")
                  ]
                ),
                Container(
                  height: 50,
                  color: Colors.red,
                  child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                        )
                )
              ]
            ),
             ],
        ),
      );
  }

}