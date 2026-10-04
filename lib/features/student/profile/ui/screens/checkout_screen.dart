import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/snackbar_helper.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/error_retry_view.dart';
import 'package:coach_space/core/widgets/guest_required_view.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/checkout_cubit.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_billing_card.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_coupon_card.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_empty_view.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_header.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_items_card.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_order_summary_card.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_section_title.dart';
import 'package:coach_space/features/student/profile/ui/widgets/checkout/checkout_success_view.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CheckoutCubit>();
        if (!GuestSession.isGuest) {
          cubit.load();
        }
        return cubit;
      },
      child: const _CheckoutView(),
    );
  }
}

class _CheckoutView extends StatefulWidget {
  const _CheckoutView();

  @override
  State<_CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<_CheckoutView> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _couponController = TextEditingController();

  String? _appliedCoupon;
  CartDto? _cart;

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
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  // ===============================================================
  // STATE CHANGES
  // ===============================================================

  void _onStateChanged(BuildContext context, CheckoutState state) {
    if (state is CheckoutReady) {
      _cart = state.cart;
      return;
    }

    if (state is CheckoutSuccess) {
      _handleSuccess(context, state);
      return;
    }

    if (state is CheckoutFailure) {
      showAppSnackBar(context, _failureMessage(context, state),
          isError: true);
    }
  }

  void _handleSuccess(BuildContext context, CheckoutSuccess state) {
    if (state.session.hasCheckoutUrl) {
      _openCheckoutUrl(context, state.session.checkoutUrl);
      return;
    }

    // The checkout was created but the backend did not return a hosted URL.
    // Show the pending message; the order can be paid later via order history.
    showAppSnackBar(context, context.l10n.checkoutProcessing);
  }

  Future<void> _openCheckoutUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    final launched = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      showAppSnackBar(
        context,
        context.l10n.checkoutPaymentOpenFailed,
        isError: true,
      );
    }
  }

  // ===============================================================
  // ACTIONS
  // ===============================================================

  void _placeOrder() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();

    context.read<CheckoutCubit>().placeOrder();
  }

  void _applyCoupon() {
    final code = _couponController.text.trim();
    setState(() {
      _appliedCoupon = code.isEmpty ? null : code;
    });

    if (code.isEmpty) return;

    showAppSnackBar(context, context.l10n.checkoutCouponApplied);
  }

  // ===============================================================
  // BUILD
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            CheckoutHeader(title: context.l10n.checkoutTitle),

            const Divider(
              height: 1,
              color: Color(0xFFE4ECE9),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: BlocConsumer<CheckoutCubit, CheckoutState>(
                listener: _onStateChanged,
                builder: (context, state) {
                  if (state is CheckoutReady) {
                    return _buildForm(context, state.cart, placing: false);
                  }

                  if (state is CheckoutPlacing) {
                    final cart = _cart;
                    if (cart != null) {
                      return _buildForm(context, cart, placing: true);
                    }
                  }

                  if (state is CheckoutSuccess) {
                    return CheckoutSuccessView(session: state.session);
                  }

                  if (state is CheckoutFailure) {
                    return _buildFailure(context, state);
                  }

                  if (state is CheckoutEmpty) {
                    return const CheckoutEmptyView();
                  }

                  if (state is CheckoutInitial && GuestSession.isGuest) {
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
  // FORM
  // ===============================================================

  Widget _buildForm(BuildContext context, CartDto cart, {
    required bool placing,
  }) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          CheckoutSectionTitle(title: l10n.checkoutOrderSummary),
          const SizedBox(height: 10),
          CheckoutItemsCard(cart: cart),
          const SizedBox(height: 22),

          CheckoutSectionTitle(title: l10n.checkoutBillingInfo),
          const SizedBox(height: 10),
          CheckoutBillingCard(
            fullNameController: _fullNameController,
            emailController: _emailController,
            fullNameValidator: _validateRequired,
            emailValidator: _validateEmail,
          ),
          const SizedBox(height: 22),

          CheckoutSectionTitle(title: l10n.checkoutCouponCode),
          const SizedBox(height: 10),
          CheckoutCouponCard(
            controller: _couponController,
            appliedCode: _appliedCoupon,
            onApply: _applyCoupon,
          ),
          const SizedBox(height: 22),

          CheckoutOrderSummaryCard(cart: cart),
          const SizedBox(height: 18),

          // =====================================================
          // PLACE ORDER
          // =====================================================

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: placing ? null : _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF8AAFA6),
                disabledForegroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: placing
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          l10n.checkoutProcessing,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      l10n.checkoutPlaceOrder,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // FAILURE
  // ===============================================================

  Widget _buildFailure(BuildContext context, CheckoutFailure state) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 40, 26, 40),
        child: ErrorRetryView(
          title: context.l10n.checkoutOrderFailed,
          detail: _failureMessage(context, state),
          onRetry: () => context.read<CheckoutCubit>().load(),
        ),
      ),
    );
  }

  // ===============================================================
  // VALIDATORS
  // ===============================================================

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.checkoutRequired;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return context.l10n.checkoutRequired;

    final emailRegex = RegExp(r'^[\w.\-+]+@[\w\-]+(\.[\w\-]+)+$');
    return emailRegex.hasMatch(text)
        ? null
        : context.l10n.checkoutInvalidEmail;
  }
}

// ===================================================================
// HELPERS
// ===================================================================

String _failureMessage(BuildContext context, CheckoutFailure state) {
  final l10n = context.l10n;
  return switch (state.kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unauthorized => l10n.errorSessionExpired,
    FailureKind.forbidden => l10n.errorForbidden,
    FailureKind.notFound => l10n.errorNotFound,
    FailureKind.conflict => l10n.errorConflict,
    FailureKind.rateLimited => l10n.errorRateLimited,
    FailureKind.serverError => l10n.checkoutPaymentFailed,
    FailureKind.validation ||
    FailureKind.businessRejection =>
        state.message.trim().isEmpty
            ? l10n.checkoutOrderFailed
            : state.message,
    FailureKind.unknown => l10n.checkoutOrderFailed,
  };
}
