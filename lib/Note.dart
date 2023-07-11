class Note {
  String date;
  String category;
  String exercise;
  int weight;

  Note({
   required this.date,
   required this.category,
   required this.exercise,
   required this.weight
  });

  Map<String, dynamic> toMap() {
    return {
     'date': date,
      'category': category,
      'exercise': exercise,
      'weight': weight
    };
  }

}