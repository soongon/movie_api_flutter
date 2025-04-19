import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_flutter/providers/movie_provider.dart';

class MovieSearchBar extends ConsumerWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SizedBox(
        height: 48,
        child: TextField(
          decoration: InputDecoration(
            hintText: '영화 제목을 입력하세요',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
          ),
          onChanged: (query) {
            ref.read(movieProvider.notifier).updateSearchQuery(query);
          },
        ),
      ),
    );
  }
}
