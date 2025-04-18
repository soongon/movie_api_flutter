import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_api_flutter/services/movie_api_service.dart';
import 'package:movie_api_flutter/widgets/shimmer_detail_card.dart';
import '../models/movie_detail.dart';

class MovieDetailScreen extends HookWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final movieDetail = useState<MovieDetail?>(null);

    useEffect(() {
      Future(() async {
        final detail = await MovieApiService.fetchMovieDetail(movieId);
        movieDetail.value = detail;
      });
      return null;
    }, []);

    if (movieDetail.value == null) {
      return const Scaffold(
        body: SafeArea(child: ShimmerDetailCard()),
      );
    }

    final m = movieDetail.value!;

    return Scaffold(
      appBar: AppBar(
        title: Text(m.title),
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
                m.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${m.posterPath}'
                    : 'https://via.placeholder.com/500x750?text=No+Image',
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // 📝 제목
            Text(
              m.title,
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
                  m.releaseDate,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.schedule, size: 18, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  '${m.runtime}분',
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
                Text('${m.voteAverage} / 10'),
              ],
            ),
            const SizedBox(height: 16),

            // 🎭 장르
            if (m.genres.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: m.genres
                    .map((genre) => Chip(
                          label: Text(genre),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: theme.colorScheme.secondaryContainer,
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),

            // 📖 줄거리
            if (m.overview.isNotEmpty) ...[
              Text('줄거리', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                m.overview,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
            ],

            // 🏢 제작사 정보
            if (m.productionCompanies.isNotEmpty) ...[
              Text('제작사', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: m.productionCompanies
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
