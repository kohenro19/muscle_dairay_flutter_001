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

    return Container(
          height: 130,
          width: MediaQuery.of(context).size.width-20,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)
            )
          ),
        );
        
  }

}