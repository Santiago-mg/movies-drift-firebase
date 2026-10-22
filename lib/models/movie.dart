
class Movie {
  final int id;
  final String title;
  final String genre;
  final bool watched;
  final String description;
  final String imagePath;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.watched,
    required this.description,
    required this.imagePath
  });

  factory Movie.fromJson(Map<String,dynamic> json) {
    return Movie(
    id: json['id'],
    title: json['title'],
    genre: json['genre'], 
    watched: json['watched'], 
    description: json['description'], 
    imagePath: json['imagePath']
    );
  }
}
