class Note {
  DateTime date;
  String category;
  String exercise;

  Note({
   required this.date,
   required this.category,
   required this.exercise

  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'category': category,
      'exercise': exercise
    };
  }

}