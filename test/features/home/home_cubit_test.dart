import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/features/student/home/data/models/category.dart';
import 'package:coach_space/features/student/home/data/models/home_data.dart';
import 'package:coach_space/features/student/home/data/models/mock_home_data.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_state.dart';

class _FakeHomeRepository implements HomeRepository {
  List<Category> categories = MockHomeData.categories;
  Object? error;

  @override
  Future<List<Category>> getCategories() async {
    if (error != null) throw error!;
    return categories;
  }

  @override
  Future<HomeData> getHomeData() async {
    if (error != null) throw error!;
    return HomeData(
      categories: categories,
      featuredCourses: MockHomeData.featuredCourses,
      trendingCourses: MockHomeData.trendingCourses,
    );
  }
}

void main() {
  group('HomeCubit', () {
    test('starts in HomeInitial', () {
      final cubit = HomeCubit(repository: _FakeHomeRepository());

      expect(cubit.state, isA<HomeInitial>());
    });

    test('emits Loading then Success from static mock data', () async {
      final cubit = HomeCubit(repository: _FakeHomeRepository());
      final emissions = <HomeState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.loadHome();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<HomeLoading>(), isA<HomeSuccess>()]);
      expect(cubit.state, isA<HomeSuccess>());

      await subscription.cancel();
    });

    test('success payload is the non-empty mock aggregate', () async {
      final cubit = HomeCubit(repository: _FakeHomeRepository());

      await cubit.loadHome();

      final state = cubit.state;
      expect(state, isA<HomeSuccess>());
      final data = (state as HomeSuccess).data;
      expect(data, isA<HomeData>());
      expect(data.isEmpty, isFalse);
      expect(data.categories.length, greaterThan(0));
      expect(data.featuredCourses.length, greaterThan(0));
      expect(data.trendingCourses.length, greaterThan(0));
      expect(data, equals(MockHomeData.aggregate));
    });
  });

  group('HomeState variants', () {
    test('support value equality', () {
      expect(const HomeEmpty(), const HomeEmpty());
      expect(const HomeOffline(), const HomeOffline());
      expect(const HomeError(), const HomeError());
      expect(const HomeError(message: 'x'), const HomeError(message: 'x'));
      expect(const HomeError(), isNot(const HomeError(message: 'x')));
      expect(const HomeLoading(), const HomeLoading());
      expect(const HomeInitial(), const HomeInitial());
    });
  });
}
