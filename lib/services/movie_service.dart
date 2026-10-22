import 'dart:async';
import 'dart:convert';

import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class MovieService {
  final String baseUrl;

  MovieService(this.baseUrl);

  Future<List<Movie>> getMovies() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => Movie.fromJson(item)).toList();
      }

      if (response.statusCode == 404) {
        throw const ApiException("Couldn't find movies");
      }

      if (response.statusCode == 500) {
        throw const ApiException("Server does not exist");
      }
      throw ApiException('Error HTTP ${response.statusCode}');
    } on TimeoutException {
      throw const ApiException('The server took too much time to response');
    }
  }
}
