class Note {
  int? no;
  String date;
  String category;
  String exercise;
  int weight;

  Note({
   this.no,
   required this.date,
   required this.category,
   required this.exercise,
   required this.weight
  });

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'date': date,
      'category': category,
      'exercise': exercise,
      'weight': weight
    };
  }

}