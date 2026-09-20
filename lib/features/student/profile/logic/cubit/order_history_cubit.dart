import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit(this._repository) : super(const OrderHistoryInitial());

  static const int _pageSize = 10;

  final OrderRepository _repository;

  int _page = 1;
  bool _hasMore = true;
  bool _loadingMore = false;
  int _generation = 0;

  Future<void> load() async {
    final generation = ++_generation;
    _page = 1;
    _hasMore = true;
    _loadingMore = false;
    emit(const OrderHistoryLoading());
    try {
      final page = await _repository.getOrders(page: 1, pageSize: _pageSize);
      if (isClosed || generation != _generation) return;
      final orders = page.results;
      _hasMore = page.next != null || orders.length < page.count;
      if (orders.isEmpty) {
        emit(const OrderHistoryEmpty());
      } else {
        emit(OrderHistorySuccess(orders, _hasMore));
      }
    } on NetworkException catch (error) {
      if (isClosed || generation != _generation) return;
      emit(OrderHistoryFailure(error.kind, error.message));
    } catch (_) {
      if (isClosed || generation != _generation) return;
      emit(const OrderHistoryFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! OrderHistorySuccess || !current.hasMore || _loadingMore) {
      return;
    }

    final generation = _generation;
    _loadingMore = true;
    try {
      final nextPage = _page + 1;
      final page = await _repository.getOrders(
        page: nextPage,
        pageSize: _pageSize,
      );
      if (isClosed || generation != _generation) return;
      _page = nextPage;
      final orders = [...current.orders, ...page.results];
      _hasMore = page.next != null || orders.length < page.count;
      emit(OrderHistorySuccess(orders, _hasMore));
    } catch (_) {
      // Keep the already loaded page on screen; the footer retries on scroll.
    } finally {
      _loadingMore = false;
    }
  }

  Future<void> refresh() => load();
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
