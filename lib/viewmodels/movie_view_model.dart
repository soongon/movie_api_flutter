import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../services/movie_api_service.dart';
import 'movie_state.dart';

/// 🎬 영화 상태 및 로직을 관리하는 뷰모델 (Riverpod StateNotifier)
class MovieViewModel extends StateNotifier<MovieState> {
  MovieViewModel() : super(MovieState.initial()) {
    loadMovies(); // 초기 데이터 로드
  }

  /// 🔁 카테고리 변경 시 상태 갱신 및 데이터 다시 로드
  /// 카테고리를 변경할 때 searchQuery를 초기화하지 않으면 검색 상태가 고정되므로,
  /// 이 코드 추가도 필요합니다 👇
  void changeCategory(int index) {
    state = state.copyWith(
      selectedIndex: index,
      searchQuery: '',
      isSearching: false,
      searchResults: [],
      isLoading: true,
    );
    loadMovies();
  }

  /// 🔍 검색어가 변경될 때마다 TMDB API 호출
  Future<void> updateSearchQuery(String query) async {
    state = state.copyWith(searchQuery: query, isSearching: true, errorMessage: null,);

    if (query.isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
      return;
    }

    try {
      final results = await MovieApiService.searchMovies(query);
      state = state.copyWith(searchResults: results, isSearching: false);
    } catch (e) {
      state = state.copyWith(
        searchResults: [],
        isSearching: false,
        errorMessage: '검색 중 오류가 발생했습니다 ❗',
      );
    }
  }

  /// 🎥 선택된 카테고리에 따른 영화 목록 요청
  Future<void> loadMovies() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final categoryMap = {
      0: 'now_playing',
      1: 'popular',
      2: 'top_rated',
      3: 'upcoming',
    };
    final selectedCategory = categoryMap[state.selectedIndex] ?? categoryMap[0] ?? 'now_playing';
    try {
      final List<Movie> movies =
          await MovieApiService.fetchMoviesByCategory(selectedCategory, 1);

      state = state.copyWith(movies: movies);
    } catch (e) {
      // 🛑 에러 발생 시: 영화 목록 비우고 에러 메시지 저장
      state = state.copyWith(
        movies: [],
        errorMessage: '영화를 불러오는 중 오류가 발생했습니다 😥',
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// 📥 스크롤 하단 도달 시 다음 페이지 불러오기
  Future<void> fetchNextPage() async {
    if (state.isFetchingMore || !state.hasNextPage || state.isSearching) return;

    state = state.copyWith(isFetchingMore: true, errorMessage: null);

    final categoryMap = {
      0: 'now_playing',
      1: 'popular',
      2: 'top_rated',
      3: 'upcoming',
    };
    final selectedCategory = categoryMap[state.selectedIndex] ?? 'now_playing';

    final nextPage = state.currentPage + 1;

    try {
      final List<Movie> nextMovies = await
          MovieApiService.fetchMoviesByCategory(selectedCategory, nextPage);

      final updatedList = [...state.movies, ...nextMovies];

      state = state.copyWith(
        movies: updatedList,
        currentPage: nextPage,
        hasNextPage: nextMovies.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: '다음 페이지 로드 중 오류 발생 😢');
    } finally {
      state = state.copyWith(isFetchingMore: false);
    }
  }
}
