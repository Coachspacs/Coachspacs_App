import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
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

            const _CartHeader(),

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
                    return _buildGuest(context);
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
                instructor: item.course.instructor.fullName,
                price: _money(item.price),
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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            l10n.cartRemoveConfirm,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          content: Text(
            l10n.cartRemoveConfirmMessage,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF687772),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(
                l10n.commonCancel,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l10n.cartRemove,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    final removed = await context.read<CartCubit>().removeItem(item.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            removed ? context.l10n.cartRemoved : context.l10n.cartRemoveFailed,
            style: GoogleFonts.inter(fontSize: 12),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: removed
              ? const Color(0xFF075E4D)
              : const Color(0xFFD9363E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 42,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0EAE7)),
            ),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4F6F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 27,
                    color: Color(0xFF075E4D),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.cartEmpty,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.cartEmptyHint,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    color: const Color(0xFF71827E),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.catalog);
                    },
                    icon: const Icon(Icons.explore_outlined, size: 17),
                    label: Text(
                      l10n.cartBrowseCourses,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
    final detail = _failureDetail(context, state.kind);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<CartCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 46,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          Text(
            l10n.cartLoadFailed,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: 6),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                color: const Color(0xFF71827E),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Center(
            child: SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: () => context.read<CartCubit>().load(),
                icon: const Icon(Icons.refresh_rounded, size: 17),
                label: Text(
                  l10n.commonRetry,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // GUEST
  // ===============================================================

  Widget _buildGuest(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: Color(0xFFE4F6F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                size: 26,
                color: Color(0xFF075E4D),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.errorSessionExpired,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                height: 1.4,
                color: const Color(0xFF40514D),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: () => LoginRequiredDialog.show(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text(
                  l10n.loginButton,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// HEADER
// ===================================================================

class _CartHeader extends StatelessWidget {
  const _CartHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        16,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(width: 4),

          Text(
            context.l10n.cartTitle,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// HELPERS
// ===================================================================

String _money(String value) {
  final amount = double.tryParse(value);
  if (amount == null) return value;
  return '\$${amount.toStringAsFixed(2)}';
}

String? _failureDetail(BuildContext context, FailureKind kind) {
  final l10n = context.l10n;
  return switch (kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unauthorized => l10n.errorSessionExpired,
    FailureKind.forbidden => l10n.errorForbidden,
    FailureKind.notFound => l10n.errorNotFound,
    FailureKind.conflict => l10n.errorConflict,
    FailureKind.rateLimited => l10n.errorRateLimited,
    FailureKind.serverError => l10n.errorServer,
    _ => null,
  };
}
