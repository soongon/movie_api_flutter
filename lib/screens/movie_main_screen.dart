import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_api_flutter/screens/movie_detail_screen.dart';
import 'package:movie_api_flutter/widgets/movie_card.dart';
import 'package:movie_api_flutter/widgets/movie_menu_item.dart';

import '../models/movie.dart';
import '../widgets/movie_search_bar.dart';

class MovieMainScreen extends HookWidget {
  const MovieMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = ['현재 상영중', '인기', '최신', '최고평점', '개봉예정'];
    final selectedIndex = useState(0);

    final List<Movie> movies = [
      Movie(id: 1, title: '노보케인', posterUrl: 'https://image.tmdb.org/t/p/w500/dVi5wC7pctrEd6vOWoteIrm3d6s.jpg', releaseDate: '2025-03-12', overview: '평범한 외모, 평범한 성격, 평범한 직업, 이보다 더 평범할 수 없는 은행원 ‘네이선 케인’은 남들과 다른 비밀을 숨기고 있다. 그것은 바로 선천성 무통각증으로 신체적 고통을 전혀 느끼지 못한다는 것. 첫눈에 반한 직장 동료 ‘셰리’와 완벽한 첫 데이트 후 설레는 마음도 잠시, 은행에 들이닥친 무장 강도단에게 ‘셰리’가 인질로 납치되고 만다. 오직 그녀를 구하겠다는 마음으로 강도를 쫓던 ‘네이선’은 자신의 특별한 능력(?)을 사용해 온몸을 무기 삼아 극한의 위험 속에 뛰어드는데…'),
      Movie(id: 2, title: '예언자', posterUrl: 'https://image.tmdb.org/t/p/w500/aPeZsD2RhFLKIVvdlb4zp4vB0Mp.jpg', releaseDate: '2010-03-11', overview: '6년 형을 선고 받고 감옥에 들어가게 된 19살의 말리크. 읽을 줄도 쓸 줄도 모르던 그에게 감옥은 선생님이 되고, 집이 되고, 친구가 된다. 감옥을 지배하던 코르시카계 갱 두목 루치아니의 강요로 어쩔 수 없이 살인이라는 첫 임무를 맡게 된 이후, 보스의 신임을 얻은 그는 빠르게 냉혹한 사회에서 살아남는 법을 배워가면서 조금씩 자신만의 세계를 구축하게 된다. 그러던 어느 날 보스는 특별한 임무를 맡기게 되고, 이를 통해 그는 자신의 운명을 바꿀 엄청난 계획을 세우게 되는데...'),
      Movie(id: 3, title: '소오강호: 동방불패', posterUrl: 'https://image.tmdb.org/t/p/w500/ihUJvu2E4OyPlNyNRyrUviHlCkh.jpg', releaseDate: '2025-04-01', overview: '강호에 웃고, 인생에 울다  독고구검의 달인 영호충은 일월신교 토벌에 휘말리지만,\r 화산파 동문들을 구출한 후 은퇴를 결심한다.\r 마지막 여정 중 폭포 아래에서 한 여인을 구하는데,\r 그녀가 마교의 신임 교주 동방불패임을 모른 채 두 사람은 강호에서 유대를 쌓는다.\r 오해와 계략 속에서 피할 수 없는 생사의 결전이 다가오고..\r 규화보전과 독고구검의 대결,  누가 마지막에 강호를 웃으며 떠날 것인가!'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('영화 앱'),
        leading: Icon(Icons.movie),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              itemBuilder: (context, index) {
                return MovieMenuItem(
                  menuName: menuItems[index],
                  isSelected: selectedIndex.value == index,
                  onSelected: () {
                    selectedIndex.value = index;
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 16,);
              },
              itemCount: menuItems.length,
            ),
          ),
          // 검색바
          MovieSearchBar(),
          // 영화목록 (카드 레이아웃)
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movie: movies[index],),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
