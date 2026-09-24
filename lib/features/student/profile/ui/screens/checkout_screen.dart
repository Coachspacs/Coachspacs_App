import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/checkout_cubit.dart';

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
      _showSnack(
        context,
        _failureMessage(context, state),
        background: const Color(0xFFD9363E),
      );
    }
  }

  void _handleSuccess(BuildContext context, CheckoutSuccess state) {
    if (state.session.hasCheckoutUrl) {
      _openCheckoutUrl(context, state.session.checkoutUrl);
      return;
    }

    // The checkout was created but the backend did not return a hosted URL.
    // Show the pending message; the order can be paid later via order history.
    _showSnack(
      context,
      context.l10n.checkoutProcessing,
      background: const Color(0xFF075E4D),
    );
  }

  Future<void> _openCheckoutUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    final launched = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      _showSnack(
        context,
        context.l10n.checkoutPaymentOpenFailed,
        background: const Color(0xFFD9363E),
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

    _showSnack(
      context,
      context.l10n.checkoutCouponApplied,
      background: const Color(0xFF075E4D),
    );
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
            // =====================================================
            // HEADER
            // =====================================================

            _CheckoutHeader(
              onBack: () {
                Navigator.pop(context);
              },
            ),

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
                    return _buildSuccess(context, state);
                  }

                  if (state is CheckoutFailure) {
                    return _buildFailure(context, state);
                  }

                  if (state is CheckoutEmpty) {
                    return _buildEmpty(context);
                  }

                  if (state is CheckoutInitial && GuestSession.isGuest) {
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
          // =====================================================
          // ORDER ITEMS
          // =====================================================

          _SectionTitle(title: l10n.checkoutOrderSummary),

          const SizedBox(height: 10),

          _ItemsCard(cart: cart),

          const SizedBox(height: 22),

          // =====================================================
          // BILLING INFORMATION
          // =====================================================

          _SectionTitle(title: l10n.checkoutBillingInfo),

          const SizedBox(height: 10),

          _BillingCard(
            fullNameController: _fullNameController,
            emailController: _emailController,
            fullNameValidator: _validateRequired,
            emailValidator: _validateEmail,
          ),

          const SizedBox(height: 22),

          // =====================================================
          // COUPON
          // =====================================================

          _SectionTitle(title: l10n.checkoutCouponCode),

          const SizedBox(height: 10),

          _CouponCard(
            controller: _couponController,
            appliedCode: _appliedCoupon,
            onApply: _applyCoupon,
          ),

          const SizedBox(height: 22),

          // =====================================================
          // TOTALS
          // =====================================================

          _OrderSummaryCard(cart: cart),

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
  // SUCCESS
  // ===============================================================

  Widget _buildSuccess(BuildContext context, CheckoutSuccess state) {
    final l10n = context.l10n;
    final session = state.session;
    final hasUrl = session.hasCheckoutUrl;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 40, 26, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3D6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.payments_outlined,
                color: const Color(0xFFB7791F),
                size: 34,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              l10n.checkoutReadyForPayment,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF073F38),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              hasUrl
                  ? l10n.checkoutReadyForPaymentHint
                  : l10n.checkoutProcessing,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                height: 1.5,
                color: const Color(0xFF71807C),
              ),
            ),

            if (session.orderId > 0) ...[
              const SizedBox(height: 8),
              Text(
                '${l10n.checkoutOrderNumber} ${session.orderId}',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF073F38),
                ),
              ),
            ],

            const SizedBox(height: 22),

            if (hasUrl)
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () => _openCheckoutUrl(context, session.checkoutUrl),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.checkoutContinuePayment,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            if (hasUrl) const SizedBox(height: 9),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.orderHistory,
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF075E4D),
                  side: const BorderSide(color: Color(0xFFBFE9D8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.checkoutViewOrders,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // EMPTY
  // ===============================================================

  Widget _buildEmpty(BuildContext context) {
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
                Icons.remove_shopping_cart_outlined,
                size: 26,
                color: Color(0xFF075E4D),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.checkoutNoItems,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.checkoutNoItemsHint,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
                  l10n.checkoutGoBack,
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

  // ===============================================================
  // FAILURE
  // ===============================================================

  Widget _buildFailure(BuildContext context, CheckoutFailure state) {
    final l10n = context.l10n;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 40, 26, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            Text(
              l10n.checkoutOrderFailed,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _failureMessage(context, state),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                height: 1.45,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: () => context.read<CheckoutCubit>().load(),
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
          ],
        ),
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

  // ===============================================================
  // HELPERS
  // ===============================================================

  void _showSnack(
    BuildContext context,
    String message, {
    required Color background,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.inter(fontSize: 12),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
// HEADER
// ===================================================================

class _CheckoutHeader extends StatelessWidget {
  const _CheckoutHeader({
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        16,
        10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
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
            context.l10n.checkoutTitle,
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
// SECTION TITLE
// ===================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }
}

// ===================================================================
// ITEMS CARD
// ===================================================================

class _ItemsCard extends StatelessWidget {
  const _ItemsCard({
    required this.cart,
  });

  final CartDto cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        children: [
          for (var index = 0; index < cart.items.length; index++) ...[
            if (index > 0) ...[
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                color: Color(0xFFE4ECE9),
              ),
              const SizedBox(height: 10),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4F6F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.play_circle_outline_rounded,
                    size: 20,
                    color: Color(0xFF075E4D),
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.items[index].course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF073F38),
                        ),
                      ),

                      const SizedBox(height: 4),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  _money(cart.items[index].course.price),
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}


// ===================================================================
// BILLING INFORMATION
// ===================================================================

class _BillingCard extends StatelessWidget {
  const _BillingCard({
    required this.fullNameController,
    required this.emailController,
    required this.fullNameValidator,
    required this.emailValidator,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final String? Function(String?) fullNameValidator;
  final String? Function(String?) emailValidator;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(
            label: l10n.checkoutFullName,
          ),

          const SizedBox(height: 6),

          _CheckoutTextField(
            controller: fullNameController,
            hintText: l10n.checkoutFullName,
            icon: Icons.person_outline_rounded,
            validator: fullNameValidator,
          ),

          const SizedBox(height: 12),

          _FieldLabel(
            label: l10n.checkoutEmail,
          ),

          const SizedBox(height: 6),

          _CheckoutTextField(
            controller: emailController,
            hintText: l10n.checkoutEmail,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// COUPON
// ===================================================================

class _CouponCard extends StatelessWidget {
  const _CouponCard({
    required this.controller,
    required this.appliedCode,
    required this.onApply,
  });

  final TextEditingController controller;
  final String? appliedCode;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF073F38),
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.checkoutCouponCode,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF9AA8A3),
                    ),
                    prefixIcon: const Icon(
                      Icons.local_offer_outlined,
                      size: 18,
                      color: Color(0xFF71827E),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FBFA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: Color(0xFFE1E9E6),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: Color(0xFFE1E9E6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    l10n.checkoutApply,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (appliedCode != null) ...[
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 14,
                  color: Color(0xFF0F8A6F),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    appliedCode!,
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF08785F),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ===================================================================
// ORDER SUMMARY
// ===================================================================

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.cart,
  });

  final CartDto cart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final total = _amount(cart.total);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        children: [
          _SummaryRow(
            title: l10n.checkoutTotal,
            value: _moneyValue(total),
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  final String title;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: isTotal ? 13 : 10.5,
              fontWeight:
              isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal
                  ? const Color(0xFF073F38)
                  : const Color(0xFF687772),
            ),
          ),
        ),

        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 15 : 10.5,
            fontWeight: FontWeight.w700,
            color: isTotal
                ? AppColors.primary
                : const Color(0xFF073F38),
          ),
        ),
      ],
    );
  }
}

// ===================================================================
// FIELD LABEL
// ===================================================================

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF073F38),
      ),
    );
  }
}

// ===================================================================
// TEXT FIELD
// ===================================================================

class _CheckoutTextField extends StatelessWidget {
  const _CheckoutTextField({
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(
        fontSize: 11,
        color: const Color(0xFF073F38),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 10.5,
          color: const Color(0xFF9AA8A3),
        ),
        prefixIcon: icon == null
            ? null
            : Icon(
          icon,
          size: 18,
          color: const Color(0xFF71827E),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FBFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Color(0xFFE1E9E6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Color(0xFFE1E9E6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// ===================================================================
// HELPERS
// ===================================================================

double _amount(String value) => double.tryParse(value) ?? 0;

String _moneyValue(double value) => '\$${value.toStringAsFixed(2)}';

String _money(String value) {
  final amount = double.tryParse(value);
  if (amount == null) return value;
  return _moneyValue(amount);
}

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
