class MovieNote {
  final int movieId;
  final String note;
  final int rating;
  final DateTime updatedAt;
  // true = solo esta en el celular, falta enviarla a Firestore.
  final bool pendingSync;

  const MovieNote({
    required this.movieId,
    required this.note,
    required this.rating,
    required this.updatedAt,
    this.pendingSync = true,
  });

  factory MovieNote.fromJson(Map<String,dynamic> json) {
    return MovieNote(
    movieId: json['movie_id'] as int, 
    note: json['note'], 
    rating: json['rating'] as int, 
    updatedAt: DateTime.parse(json['updated_at'])
    );
  }

  Map<String,dynamic> toJson() => {
    'movie_id':movieId,
    'note':note,
    'rating':rating,
    'updated_at':updatedAt.toIso8601String()
  };
}
