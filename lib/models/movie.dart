class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String releaseDate;
  final String overview;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    const baseImageUrl = 'https://image.tmdb.org/t/p/w500';

    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      posterUrl: json['poster_path'] != null
          ? '$baseImageUrl${json['poster_path']}'
          : '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
    );
  }
}