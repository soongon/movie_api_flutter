import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 🎬 영화 상세정보 로딩용 ShimmerCard
class ShimmerDetailCard extends StatelessWidget {
  const ShimmerDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔳 포스터 또는 배경 이미지 영역
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            // 🏷️ 제목 영역
            Container(
              width: 200,
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            // 📅 개봉일
            Container(
              width: 150,
              height: 16,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            // 📄 줄거리 영역
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
