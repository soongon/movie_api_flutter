import 'dart:convert';
import 'package:movie_api_flutter/models/movie.dart';
import 'package:http/http.dart' as http;

import '../models/movie_detail.dart';

// 🎬 TMDB API로부터 영화 데이터를 가져오는 서비스 클래스
class MovieApiService {
  // 🌐 TMDB API 기본 URL
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // 🔐 TMDB API 인증용 Bearer Token
  static const String _accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDM3YTAwN2ZhMmE5MzM1NTdmNWYyMzBlMGYyZTYwZiIsIm5iZiI6MTY4Nzc2MzE4MS4zODUsInN1YiI6IjY0OTkzOGVkNmY0M2VjMDBjNWM3MmY4NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.c36HQAp9HEFqYlAdtspic4Deb284ZTrc-YGOliBHkuk';

  // 🎞️ 현재 상영중인 영화 리스트 가져오기
  static Future<List<Movie>> fetchNowPlayingMovies() async {
    // 📡 요청 보낼 URL 정의 (한국어, 한국 지역 기준)
    final url = Uri.parse('$_baseUrl/movie/now_playing?language=ko-KR&page=1&region=kr');

    // 📥 HTTP GET 요청 실행
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken', // 인증 헤더
        'accept': 'application/json',             // 응답 형식 설정
      }
    );

    // ✅ 요청 성공 (200 OK)
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);         // JSON 문자열 → Map 디코딩
      final List<dynamic> results = jsonData['results'];   // 영화 리스트 추출

      // 🛠️ JSON → Movie 객체로 변환하여 리스트 반환
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      // ❌ 오류 처리
      throw Exception('영화 목록을 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  // 🔥 인기 영화 목록 가져오기
  static Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$_baseUrl/movie/popular?language=ko-KR&page=1&region=kr');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('인기 영화 목록을 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  // 🏆 최고 평점 영화 목록 가져오기
  static Future<List<Movie>> fetchTopRatedMovies() async {
    final url = Uri.parse('$_baseUrl/movie/top_rated?language=ko-KR&page=1&region=kr');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('최고 평점 영화 목록을 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  // 🎬 개봉 예정 영화 목록 가져오기
  static Future<List<Movie>> fetchUpcomingMovies() async {
    final url = Uri.parse('$_baseUrl/movie/upcoming?language=ko-KR&page=1&region=kr');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('개봉 예정 영화 목록을 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  // 🧾 영화 상세 정보 가져오기
  static Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId?language=ko-KR');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'accept': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return MovieDetail.fromJson(jsonData);
    } else {
      throw Exception('영화 상세 정보를 불러오는 데 실패했습니다: ${response.statusCode}');
    }
  }

  // 🔍 영화 검색 기능 (query 기반)
  static Future<List<Movie>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeQueryComponent(query);
    final url = Uri.parse('$_baseUrl/search/movie?query=$encodedQuery&include_adult=false&language=ko-KR&page=1');

    final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'accept': 'application/json',
        }
    );
  print('[검색 응답] ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('영화 검색에 실패했습니다: ${response.statusCode}');
    }
  }
}