import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/features/home/data/models/home_data.dart';
import 'package:coach_space/features/home/data/models/mock_home_data.dart';
import 'package:coach_space/features/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/home/logic/cubit/home_state.dart';

void main() {
  group('HomeCubit', () {
    test('starts in HomeInitial', () {
      final cubit = HomeCubit();

      expect(cubit.state, isA<HomeInitial>());
    });

    test('emits Loading then Success from static mock data', () async {
      final cubit = HomeCubit();
      final emissions = <HomeState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.loadHome();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<HomeLoading>(), isA<HomeSuccess>()]);
      expect(cubit.state, isA<HomeSuccess>());

      await subscription.cancel();
    });

    test('success payload is the non-empty mock aggregate', () async {
      final cubit = HomeCubit();

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
