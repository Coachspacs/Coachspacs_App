import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/formatters.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/helpers/snackbar_helper.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/back_title_header.dart';
import 'package:coach_space/core/widgets/confirm_dialog.dart';
import 'package:coach_space/core/widgets/empty_state_card.dart';
import 'package:coach_space/core/widgets/error_retry_view.dart';
import 'package:coach_space/core/widgets/guest_required_view.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/cart_cubit.dart';

import '../widgets/cart/cart_item.dart';
import '../widgets/cart/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CartCubit>();
        if (!GuestSession.isGuest) {
          cubit.load();
        }
        return cubit;
      },
      child: const _CartView(),
    );
  }
}

class _CartView extends StatefulWidget {
  const _CartView();

  @override
  State<_CartView> createState() => _CartViewState();
}

class _CartViewState extends State<_CartView> {
  @override
  void initState() {
    super.initState();
    if (GuestSession.isGuest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) LoginRequiredDialog.show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            BackTitleHeader(title: context.l10n.cartTitle),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartSuccess) {
                    if (state.cart.isEmpty) {
                      return _buildEmpty(context);
                    }
                    return _buildCart(context, state.cart);
                  }

                  if (state is CartFailure) {
                    return _buildFailure(context, state);
                  }

                  if (state is CartInitial && GuestSession.isGuest) {
                    return const GuestRequiredView();
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF075E4D),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // CART
  // ===============================================================

  Widget _buildCart(BuildContext context, CartDto cart) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CartCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        children: [
          ...cart.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: CartItem(
                title: item.course.title,
                price: formatMoney(item.course.price),
                image: item.course.coverImage,
                onDelete: () => _confirmRemove(context, item),
              ),
            ),
          ),

          const SizedBox(height: 4),

          CartSummary(
            cart: cart,
            onCheckout: () => _openCheckout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _openCheckout(BuildContext context) async {
    await Navigator.pushNamed(context, AppRoutes.checkout);
    if (!context.mounted) return;
    if (GuestSession.isGuest) return;
    await context.read<CartCubit>().load();
  }

  // ===============================================================
  // REMOVE
  // ===============================================================

  Future<void> _confirmRemove(BuildContext context, CartItemDto item) async {
    final l10n = context.l10n;

    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.cartRemoveConfirm,
      message: l10n.cartRemoveConfirmMessage,
      confirmLabel: l10n.cartRemove,
      cancelLabel: l10n.commonCancel,
      destructive: true,
    );

    if (!confirmed || !context.mounted) return;

    final removed = await context.read<CartCubit>().removeItem(item.id);
    if (!context.mounted) return;

    showAppSnackBar(
      context,
      removed ? context.l10n.cartRemoved : context.l10n.cartRemoveFailed,
      isError: !removed,
    );
  }

  // ===============================================================
  // EMPTY
  // ===============================================================

  Widget _buildEmpty(BuildContext context) {
    final l10n = context.l10n;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CartCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
        children: [
          EmptyStateCard(
            icon: Icons.shopping_cart_outlined,
            title: l10n.cartEmpty,
            hint: l10n.cartEmptyHint,
            ctaLabel: l10n.cartBrowseCourses,
            ctaIcon: Icons.explore_outlined,
            onCta: () => Navigator.pushNamed(context, AppRoutes.catalog),
            iconBadgeSize: 58,
            iconSize: 27,
            titleFontSize: 16,
            hintFontSize: 11.5,
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // FAILURE
  // ===============================================================

  Widget _buildFailure(BuildContext context, CartFailure state) {
    final l10n = context.l10n;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CartCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          ErrorRetryView(
            title: l10n.cartLoadFailed,
            detail: failureDetail(context, state.kind),
            onRetry: () => context.read<CartCubit>().load(),
          ),
        ],
      ),
    );
  }
}
