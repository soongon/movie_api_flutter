import 'package:equatable/equatable.dart';

import '../models/movie.dart';

/// 🎬 화면 상태를 담는 상태 모델 클래스
class MovieState extends Equatable {
  /// 📌 선택된 메뉴 인덱스 (예: 0 = 현재 상영, 1 = 인기 등)
  final int selectedIndex;

  /// 🎞️ 현재 화면에 표시할 영화 목록
  final List<Movie> movies;

  /// ⏳ 로딩 중 여부 (API 호출 중 상태)
  final bool isLoading;

  /// 🔍 검색 쿼리
  final String searchQuery;

  /// 🔍 검색 중 여부
  final bool isSearching;

  /// 🎞️ 검색 결과 목록
  final List<Movie> searchResults;

  /// 에러메세지
  final String? errorMessage;


  const MovieState({
    required this.selectedIndex,
    required this.movies,
    required this.isLoading,
    required this.searchQuery,
    required this.isSearching,
    required this.searchResults,
    this.errorMessage,
  });

  /// 🆕 초기 상태 생성자 (앱 시작 시 기본 상태)
  factory MovieState.initial() {
    return MovieState(
      selectedIndex: 0,
      movies: [],
      isLoading: false,
      searchQuery: '',
      isSearching: false,
      searchResults: [],
    );
  }

  /// 🔁 기존 상태에서 일부 값만 변경할 수 있는 copyWith 메서드
  MovieState copyWith({
    int? selectedIndex,
    List<Movie>? movies,
    bool? isLoading,
    String? searchQuery,
    bool? isSearching,
    List<Movie>? searchResults,
    String? errorMessage,
  }) {
    return MovieState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage, // ⛔ 명시적으로 전달된 값만 사용
    );
  }

  @override
  /// 📋 상태 객체 비교를 위한 Equatable의 props 설정
  /// 포함된 값이 하나라도 다르면 상태가 변경된 것으로 간주됨
  List<Object?> get props => [
    movies,
    searchResults,
    searchQuery,
    selectedIndex,
    isLoading,
    errorMessage,
  ];
}
