import 'package:flutter/material.dart';
import '../models/movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetail movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎬 포스터 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://via.placeholder.com/500x750?text=No+Image',
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // 📝 제목
            Text(
              movie.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 📅 개봉일 · ⏱️ 상영시간
            Row(
              children: [
                Icon(Icons.event, size: 18, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  movie.releaseDate,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 18, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  '${movie.runtime}분',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ⭐ 평점
            Row(
              children: [
                Icon(Icons.star_rate_rounded, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${movie.voteAverage} / 10'),
              ],
            ),
            const SizedBox(height: 16),

            // 🎭 장르
            if (movie.genres.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: movie.genres
                    .map((genre) => Chip(
                          label: Text(genre),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: theme.colorScheme.secondaryContainer,
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),

            // 📖 줄거리
            if (movie.overview.isNotEmpty) ...[
              Text('줄거리', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                movie.overview,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
            ],

            // 🏢 제작사 정보
            if (movie.productionCompanies.isNotEmpty) ...[
              Text('제작사', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: movie.productionCompanies
                    .map((company) => Chip(
                          label: Text(company),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        ))
                    .toList(),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
