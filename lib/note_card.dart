import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'note.dart';

class Notecard extends StatefulWidget {

  // final int? id;
  final String title;
  // final int? weatherCode;
  // final int? emotion;
  // final DateTime createdDate; // String型だとエラーになる
  // final Function insertFunction;
  // final Function deleteFunction;

  const Notecard({
    // required this.id,
    required this.title,
    // required this.weatherCode,
    // required this.emotion,
    // required this.createdDate,
    // required this.insertFunction, // it will handle the changes in checkbox
    // required this.deleteFunction, // it will handle the delete button function
          Key? key }) : super(key: key);

  @override
  State<Notecard> createState() => _NotecardState();
}

class _NotecardState extends State<Notecard> {
  @override
  Widget build(BuildContext context) {

    // var anotherNote = Note(
    //   id: widget.id, 
    //   title: widget.title,
    //   weatherCode: widget.weatherCode,
    //   emotion: widget.emotion,
    //   createdDate: widget.createdDate
    // );

    var card = Card(
      child: GestureDetector(
        child: Row(
          children: [
            // getEmotionIcon(widget.emotion),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title)
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(DateFormat('dd MMM yyyy').format(widget.createdDate))
                ],
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                // add delete method
                // widget.deleteFunction(anotherNote);
              },
              icon: const Icon(Icons.close),
            ),
          
          ]
          
          ,
        ),
      ),
    );
    return card;
  }

	// Returns the priority icon
	Icon getEmotionIcon(int? priority) {
		switch (priority) {
			case 0:
				return Icon(Icons.favorite, color: Colors.pink.shade100,);
			case 1:
				return Icon(Icons.sick, color: Colors.grey.shade600,);
			default:
				return Icon(Icons.favorite);
		}
	}

}