import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = 'card';
  bool saveCard = true;

  final TextEditingController cardholderController =
  TextEditingController();

  final TextEditingController cardNumberController =
  TextEditingController();

  final TextEditingController expiryController =
  TextEditingController();

  final TextEditingController cvvController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController(text: 'sondos@example.com');

  final TextEditingController couponController =
  TextEditingController();

  @override
  void dispose() {
    cardholderController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    emailController.dispose();
    couponController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double coursePrice = 89.00;

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // COURSE SUMMARY
                    // =================================================

                    _SectionTitle(
                      title: 'Course Summary',
                    ),

                    const SizedBox(height: 10),

                    _CourseSummaryCard(
                      title:
                      'Next.js 15 & React 19 Fullstack Masterclass',
                      instructor: 'Dr. Tareq Al-Mansoor',
                      price: coursePrice,
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // PAYMENT METHOD
                    // =================================================

                    _SectionTitle(
                      title: 'Payment Method',
                    ),

                    const SizedBox(height: 10),

                    _PaymentMethodCard(
                      selectedPayment: selectedPayment,
                      onPaymentChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                    ),

                    if (selectedPayment == 'card') ...[
                      const SizedBox(height: 14),

                      _CardDetailsCard(
                        cardholderController: cardholderController,
                        cardNumberController: cardNumberController,
                        expiryController: expiryController,
                        cvvController: cvvController,
                        saveCard: saveCard,
                        onSaveCardChanged: (value) {
                          setState(() {
                            saveCard = value;
                          });
                        },
                      ),
                    ],

                    const SizedBox(height: 22),

                    // =================================================
                    // LEARNER & RECEIPT INFORMATION
                    // =================================================

                    _SectionTitle(
                      title: 'Learner & Receipt Information',
                    ),

                    const SizedBox(height: 10),

                    _ReceiptInformationCard(
                      emailController: emailController,
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // COUPON
                    // =================================================

                    _SectionTitle(
                      title: 'Coupon / Gift Code',
                    ),

                    const SizedBox(height: 10),

                    _CouponCard(
                      controller: couponController,
                      onApply: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Coupon will be applied during checkout.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // ORDER SUMMARY
                    // =================================================

                    _SectionTitle(
                      title: 'Order Summary',
                    ),

                    const SizedBox(height: 10),

                    _OrderSummaryCard(
                      subtotal: coursePrice,
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // PAY BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Pay \$89.00 Now',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =================================================
                    // GUARANTEE
                    // =================================================

                    Center(
                      child: Text(
                        '30-Day Money-Back Guarantee • Immediate Course Access',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: const Color(0xFF71827E),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // BENEFITS
                    // =================================================

                    const _CheckoutBenefits(),

                    const SizedBox(height: 16),

                    // =================================================
                    // TERMS
                    // =================================================

                    Center(
                      child: Text(
                        'By completing your purchase, you agree to our '
                            'Terms of Service and Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          height: 1.5,
                          color: const Color(0xFF7A8884),
                        ),
                      ),
                    ),
                  ],
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
            'Checkout',
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
// COURSE SUMMARY
// ===================================================================

class _CourseSummaryCard extends StatelessWidget {
  const _CourseSummaryCard({
    required this.title,
    required this.instructor,
    required this.price,
  });

  final String title;
  final String instructor;
  final double price;

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFE4F6F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.play_circle_outline_rounded,
              size: 30,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  instructor,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: const Color(0xFF71827E),
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.all_inclusive_rounded,
                      size: 13,
                      color: Color(0xFF075E4D),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lifetime Access',
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF075E4D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            '\$${price.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 13,
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
// PAYMENT METHOD
// ===================================================================

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.selectedPayment,
    required this.onPaymentChanged,
  });

  final String selectedPayment;
  final ValueChanged<String> onPaymentChanged;

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
          _PaymentOption(
            value: 'card',
            selected: selectedPayment == 'card',
            title: 'Credit / Debit Card',
            icon: Icons.credit_card_rounded,
            onTap: () => onPaymentChanged('card'),
          ),

          const SizedBox(height: 10),

          _PaymentOption(
            value: 'apple',
            selected: selectedPayment == 'apple',
            title: 'Apple Pay',
            icon: Icons.apple_rounded,
            onTap: () => onPaymentChanged('apple'),
          ),

          const SizedBox(height: 10),

          _PaymentOption(
            value: 'paypal',
            selected: selectedPayment == 'paypal',
            title: 'PayPal',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => onPaymentChanged('paypal'),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.value,
    required this.selected,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String value;
  final bool selected;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE8F6F1)
              : const Color(0xFFF9FBFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : const Color(0xFFE1E9E6),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? AppColors.primary
                  : const Color(0xFF71827E),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF073F38),
                ),
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : const Color(0xFFB7C5C0),
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// CARD DETAILS
// ===================================================================

class _CardDetailsCard extends StatelessWidget {
  const _CardDetailsCard({
    required this.cardholderController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.saveCard,
    required this.onSaveCardChanged,
  });

  final TextEditingController cardholderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final bool saveCard;
  final ValueChanged<bool> onSaveCardChanged;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(
            label: 'Cardholder Name',
          ),

          const SizedBox(height: 6),

          _CheckoutTextField(
            controller: cardholderController,
            hintText: 'Enter cardholder name',
            icon: Icons.person_outline_rounded,
          ),

          const SizedBox(height: 12),

          _FieldLabel(
            label: 'Card Number',
          ),

          const SizedBox(height: 6),

          _CheckoutTextField(
            controller: cardNumberController,
            hintText: '0000 0000 0000 0000',
            icon: Icons.credit_card_outlined,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FieldLabel(
                      label: 'Expiry Date',
                    ),
                    const SizedBox(height: 6),
                    _CheckoutTextField(
                      controller: expiryController,
                      hintText: 'MM / YY',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FieldLabel(
                      label: 'CVV / CVC',
                    ),
                    const SizedBox(height: 6),
                    _CheckoutTextField(
                      controller: cvvController,
                      hintText: '123',
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: saveCard,
                  onChanged: (value) {
                    onSaveCardChanged(value ?? false);
                  },
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              const SizedBox(width: 7),

              Text(
                'Save this card for future purchases',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: const Color(0xFF687772),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// RECEIPT INFORMATION
// ===================================================================

class _ReceiptInformationCard extends StatelessWidget {
  const _ReceiptInformationCard({
    required this.emailController,
  });

  final TextEditingController emailController;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldLabel(
            label: 'Receipt Email',
          ),

          const SizedBox(height: 6),

          _CheckoutTextField(
            controller: emailController,
            hintText: 'Email address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 12),

          const _FieldLabel(
            label: 'Billing Country',
          ),

          const SizedBox(height: 6),

          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFA),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFE1E9E6),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.public_outlined,
                  size: 18,
                  color: Color(0xFF71827E),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    'Palestine',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 19,
                  color: Color(0xFF71827E),
                ),
              ],
            ),
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
    required this.onApply,
  });

  final TextEditingController controller;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF073F38),
              ),
              decoration: InputDecoration(
                hintText: 'Enter coupon or gift code',
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
                'Apply',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
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
    required this.subtotal,
  });

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    const double discount = 0.00;
    const double taxes = 0.00;
    final double total = subtotal - discount + taxes;

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
            title: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 10),

          _SummaryRow(
            title: 'Coupon Discount',
            value: '-\$${discount.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 10),

          _SummaryRow(
            title: 'Taxes & VAT',
            value: '\$${taxes.toStringAsFixed(2)}',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Divider(
              height: 1,
              color: Color(0xFFE5ECE9),
            ),
          ),

          _SummaryRow(
            title: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
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
// BENEFITS
// ===================================================================

class _CheckoutBenefits extends StatelessWidget {
  const _CheckoutBenefits();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _Benefit(
              icon: Icons.verified_user_outlined,
              title: 'Secure',
              subtitle: 'Payment',
            ),
          ),
          _BenefitDivider(),
          Expanded(
            child: _Benefit(
              icon: Icons.replay_rounded,
              title: '30-Day',
              subtitle: 'Guarantee',
            ),
          ),
          _BenefitDivider(),
          Expanded(
            child: _Benefit(
              icon: Icons.support_agent_outlined,
              title: '24/7',
              subtitle: 'Support',
            ),
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFE4F6F0),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),

        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 8.5,
            color: const Color(0xFF687772),
          ),
        ),
      ],
    );
  }
}

class _BenefitDivider extends StatelessWidget {
  const _BenefitDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 45,
      color: const Color(0xFFE1E9E6),
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
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
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
      ),
    );
  }
}