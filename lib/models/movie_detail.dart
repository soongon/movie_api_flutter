class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int budget;
  final int revenue;
  final List<String> genres;
  final List<String> productionCompanies;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.budget,
    required this.revenue,
    required this.genres,
    required this.productionCompanies,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => genre['name'] as String)
          .toList(),
      productionCompanies: (json['production_companies'] as List<dynamic>)
          .map((company) => company['name'] as String)
          .toList(),
    );
  }
}