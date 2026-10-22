import 'package:flutter_test/flutter_test.dart';
import 'package:movies/models/movie.dart';

void main() {
  test('Movie.fromJson convierte el JSON', () {
    final movie = Movie.fromJson({
      'id': 1,
      'title': 'Titulo',
      'genre': 'Drama',
      'watched': true,
      'description': 'Una descripcion',
      'imagePath': 'assets/images/a.jpg',
    });

    expect(movie.id, 1);
    expect(movie.title, 'Titulo');
    expect(movie.watched, true);
  });
}
