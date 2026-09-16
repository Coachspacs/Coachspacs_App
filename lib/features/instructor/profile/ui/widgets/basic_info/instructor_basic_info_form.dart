import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorBasicInfoForm extends StatefulWidget {
  const InstructorBasicInfoForm({
    super.key,
    required this.nameController,
    required this.titleController,
    required this.headlineController,
    required this.experienceController,
    required this.phoneController,
    required this.emailController,
    required this.hourlyRateController,
    required this.locationController,
    required this.bioController,
    required this.skillSearchController,
    required this.specialization,
    required this.skills,
    required this.onSpecializationChanged,
    required this.onRemoveSkill,
    required this.onAddSkill,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController headlineController;
  final TextEditingController experienceController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController hourlyRateController;
  final TextEditingController locationController;
  final TextEditingController bioController;
  final TextEditingController skillSearchController;

  final String specialization;
  final List<String> skills;

  final ValueChanged<String> onSpecializationChanged;
  final ValueChanged<String> onRemoveSkill;
  final ValueChanged<String> onAddSkill;

  final VoidCallback onSave;

  @override
  State<InstructorBasicInfoForm> createState() =>
      _InstructorBasicInfoFormState();
}

class _InstructorBasicInfoFormState
    extends State<InstructorBasicInfoForm> {
  bool _teachingSkillsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // PROFILE CARD
          // =====================================================

          _buildProfileCard(),

          const SizedBox(height: 20),

          // =====================================================
          // PERSONAL INFO
          // =====================================================

          _buildField(
            label: 'Full Name',
            required: true,
            controller: widget.nameController,
          ),

          const SizedBox(height: 14),

          _buildField(
            label: 'Professional Title',
            controller: widget.titleController,
          ),

          const SizedBox(height: 14),

          _buildDropdownField(
            label: 'Specialization | Main Domain',
            required: true,
            value: widget.specialization,
            items: const [
              'Software Development',
              'Mobile App Development',
              'Web Development',
              'UI/UX Design',
              'Data Science',
              'Artificial Intelligence',
              'Cyber Security',
            ],
            onChanged: widget.onSpecializationChanged,
          ),

          const SizedBox(height: 14),

          _buildField(
            label: 'Profile Headline',
            controller: widget.headlineController,
          ),

          const SizedBox(height: 14),

          _buildField(
            label: 'Years of Experience',
            required: true,
            controller: widget.experienceController,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 14),

          _buildField(
            label: 'Phone Number',
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 14),

          // =====================================================
          // EMAIL
          // =====================================================

          Row(
            children: [
              Expanded(
                child: _fieldLabel(
                  'Email Address',
                  suffix: 'Change',
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          _buildReadOnlyField(
            controller: widget.emailController,
          ),

          const SizedBox(height: 14),

          // =====================================================
          // HOURLY RATE
          // =====================================================

          _buildField(
            label: 'Hourly Rate / Consultation',
            optional: true,
            controller: widget.hourlyRateController,
            hintText: 'e.g. \$50/hr',
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 14),

          // =====================================================
          // LOCATION
          // =====================================================

          _buildField(
            label: 'Location / Country',
            optional: true,
            controller: widget.locationController,
            suffixIcon: Icons.keyboard_arrow_down_rounded,
          ),

          const SizedBox(height: 20),

          // =====================================================
          // SKILLS
          // =====================================================

          _buildSkillsSection(),

          const SizedBox(height: 20),

          // =====================================================
          // BIO
          // =====================================================

          _buildBioSection(),

          const SizedBox(height: 26),

          // =====================================================
          // SAVE
          // =====================================================

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save changes  →',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PROFILE CARD
  // =========================================================

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -----------------------------------------------------
          // AVATAR
          // -----------------------------------------------------

          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F4F0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'H',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 13),

          // -----------------------------------------------------
          // INFO
          // -----------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hassan Sayed',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Update your personal and professional '
                      'information to be displayed.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.4,
                    color: const Color(0xFF7A8985),
                  ),
                ),

                const SizedBox(height: 10),

                // -------------------------------------------------
                // CHANGE PHOTO
                // -------------------------------------------------

                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Photo upload will be connected later.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 15,
                  ),
                  label: Text(
                    'Change Photo',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF075E4D),
                    side: const BorderSide(
                      color: Color(0xFFBFDAD3),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: const Size(0, 34),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
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

  // =========================================================
  // SKILLS SECTION
  // =========================================================

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------------------------
        // TITLE + SWITCH
        // -----------------------------------------------------

        Row(
          children: [
            Expanded(
              child: Text(
                'Is teaching Skills & Domains',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF073F38),
                ),
              ),
            ),
            Switch(
              value: _teachingSkillsEnabled,
              onChanged: (value) {
                setState(() {
                  _teachingSkillsEnabled = value;
                });
              },
              activeThumbColor: const Color(0xFF075E4D),
              activeTrackColor: const Color(0xFFCFEDE3),
            ),
          ],
        ),

        Text(
          'Choose the skills you teach',
          style: GoogleFonts.inter(
            fontSize: 11.5,
            color: const Color(0xFF899792),
          ),
        ),

        const SizedBox(height: 11),

        // -----------------------------------------------------
        // ADD + SEARCH
        // -----------------------------------------------------

        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {
                _showAddSkillDialog(context);
              },
              icon: const Icon(
                Icons.add,
                size: 16,
              ),
              label: Text(
                'Add a skill',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF075E4D),
                side: const BorderSide(
                  color: Color(0xFFBFDAD3),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 10,
                ),
                minimumSize: const Size(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: widget.skillSearchController,
                  onSubmitted: widget.onAddSkill,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF334842),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type or search to add more...',
                    hintStyle: GoogleFonts.inter(

                      fontSize: 11.5,
                      color: const Color(0xFF9AA6A2),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 17,
                      color: Color(0xFF8A9893),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 9,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color(0xFFDCE7E4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color(0xFFDCE7E4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color(0xFF075E4D),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // -----------------------------------------------------
        // TAUGHT CATEGORIES
        // -----------------------------------------------------

        Row(
          children: [
            Text(
              'Taught categories',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF52635F),
              ),
            ),

            const Spacer(),

            Text(
              'REORDER  ☷',
              style: GoogleFonts.inter(

                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF899792),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        // -----------------------------------------------------
        // SKILL CHIPS
        // -----------------------------------------------------

        Wrap(
          spacing: 7,
          runSpacing: 8,
          children: widget.skills
              .map(
                (skill) => _buildSkillChip(skill),
          )
              .toList(),
        ),
      ],
    );
  }

  // =========================================================
  // SKILL CHIP
  // =========================================================

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8F7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDDE6E3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '•',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 4),

          Text(
            skill,
            style: GoogleFonts.inter(


              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF42544F),
            ),
          ),

          const SizedBox(width: 6),

          GestureDetector(
            onTap: () {
              widget.onRemoveSkill(skill);
            },
            child: const Icon(
              Icons.close_rounded,
              size: 13,
              color: Color(0xFF87938F),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BIO
  // =========================================================

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio / About Me',
          style: GoogleFonts.inter(

            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: widget.bioController,
          minLines: 5,
          maxLines: 7,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            height: 1.5,
            color: const Color(0xFF40524E),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText:
            'Write a short introduction about yourself...',
            hintStyle: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF9AA6A2),
            ),
            contentPadding: const EdgeInsets.all(13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDCE7E4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDCE7E4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF075E4D),
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Give a short and clear bio introduction to your skills, '
              'path, and experience.',
          style: GoogleFonts.inter(



            fontSize: 10.5,
            height: 1.4,
            color: const Color(0xFF899792),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    bool required = false,
    bool optional = false,
    String? hintText,
    TextInputType? keyboardType,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(
          label,
          required: required,
          optional: optional,
        ),

        const SizedBox(height: 7),

        SizedBox(
          height: 42,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF334842),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 12.5,
                color: const Color(0xFFA0AAA7),
              ),
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(
                suffixIcon,
                size: 18,
                color: const Color(0xFF7C8C87),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDCE7E4),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDCE7E4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF075E4D),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // READ ONLY FIELD
  // =========================================================

  Widget _buildReadOnlyField({
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        readOnly: true,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFF53635E),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF7F9F8),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFDCE7E4),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFDCE7E4),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // DROPDOWN
  // =========================================================

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(
          label,
          required: required,
        ),

        const SizedBox(height: 7),

        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFDCE7E4),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: Color(0xFF7C8C87),
              ),
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF334842),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // FIELD LABEL
  // =========================================================

  Widget _fieldLabel(
      String text, {
        bool required = false,
        bool optional = false,
        String? suffix,
      }) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: text,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF40524E),
              ),
              children: [
                if (required)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Color(0xFFD94B45),
                    ),
                  ),
              ],
            ),
          ),
        ),

        if (optional)
          Text(
            'Optional',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF9AA6A2),
            ),
          ),

        if (suffix != null)
          Text(
            suffix,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF15966F),
            ),
          ),
      ],
    );
  }

  // =========================================================
  // ADD SKILL DIALOG
  // =========================================================

  void _showAddSkillDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Add a skill',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'e.g. Flutter',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAddSkill(controller.text);
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }
}