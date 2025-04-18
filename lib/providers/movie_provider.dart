import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/movie_view_model.dart';
import '../viewmodels/movie_state.dart';

/// 🎬 무비 상태를 관리하는 리버팟 Provider
final movieProvider =
    StateNotifierProvider<MovieViewModel, MovieState>((ref) {
      return MovieViewModel();
    });
