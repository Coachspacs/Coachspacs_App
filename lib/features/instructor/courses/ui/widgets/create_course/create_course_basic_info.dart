import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCourseBasicInfo
    extends StatelessWidget {
  const CreateCourseBasicInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.selectedCategory,
    required this.selectedLevel,
    required this.selectedLanguage,
    required this.onCategoryChanged,
    required this.onLevelChanged,
    required this.onLanguageChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final String selectedCategory;
  final String selectedLevel;
  final String selectedLanguage;

  final ValueChanged<String>
  onCategoryChanged;

  final ValueChanged<String>
  onLevelChanged;

  final ValueChanged<String>
  onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Course Information',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 4),



        const SizedBox(height: 18),

        // =================================================
        // THUMBNAIL
        // =================================================

        _UploadThumbnail(),

        const SizedBox(height: 16),

        // =================================================
        // TITLE
        // =================================================

        _FieldLabel('Course Title'),

        const SizedBox(height: 5),

        _TextField(
          controller: titleController,
          hint:
          'e.g. Advanced Programming Masterclass',
        ),

        const SizedBox(height: 12),

        // =================================================
        // CATEGORY
        // =================================================

        _FieldLabel('Category'),

        const SizedBox(height: 5),

        _DropdownField(
          value: selectedCategory,
          items: const [
            'Select a category',
            'Development',
            'Design',
            'Business',
            'AI & Technology',
          ],
          onChanged: onCategoryChanged,
        ),

        const SizedBox(height: 12),

        // =================================================
        // LEVEL
        // =================================================

        _FieldLabel('Difficulty Level'),

        const SizedBox(height: 5),

        _DropdownField(
          value: selectedLevel,
          items: const [
            'Beginner',
            'Intermediate',
            'Advanced',
          ],
          onChanged: onLevelChanged,
        ),

        const SizedBox(height: 12),

        // =================================================
        // DESCRIPTION
        // =================================================

        _FieldLabel('Description'),

        const SizedBox(height: 5),

        TextField(
          controller: descriptionController,
          maxLines: 5,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: const Color(0xFF263C38),
          ),
          decoration: _inputDecoration(
            'Write a brief overview of your course...',
          ),
        ),

        const SizedBox(height: 12),

        // =================================================
        // LANGUAGE
        // =================================================

        _FieldLabel('Course Language'),

        const SizedBox(height: 5),

        _DropdownField(
          value: selectedLanguage,
          items: const [
            'English',
            'Arabic',
            'Bilingual (EN/AR)',
          ],
          onChanged: onLanguageChanged,
        ),

        const SizedBox(height: 16),

        // =================================================
        // PRICING
        // =================================================

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F6F1),
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Pricing',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      const Color(0xFF073F38),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    'Make this course free',
                    style: GoogleFonts.inter(
                      fontSize: 7.5,
                      color:
                      const Color(0xFF667570),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Switch(
                    value: false,
                    onChanged: (_) {},
                    activeThumbColor:
                    const Color(0xFF075E4D),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              Text(
                'Set the price students will pay.',
                style: GoogleFonts.inter(
                  fontSize: 7.5,
                  color:
                  const Color(0xFF788681),
                ),
              ),

              const SizedBox(height: 8),

              _TextField(
                controller: priceController,
                hint: '\$ 0.00',
                keyboardType:
                TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// UPLOAD THUMBNAIL
// =====================================================

class _UploadThumbnail
    extends StatelessWidget {
  const _UploadThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F9F7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD3E3DE),
        ),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F2EC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_photo_alternate_outlined,
              size: 17,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Upload Thumbnail',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF263C38),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            'PNG, JPG up to 5MB',
            style: GoogleFonts.inter(
              fontSize: 7,
              color: const Color(0xFF899792),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// FIELD LABEL
// =====================================================

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 8.5,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF263C38),
      ),
    );
  }
}

// =====================================================
// TEXT FIELD
// =====================================================

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(
        fontSize: 10,
        color: const Color(0xFF263C38),
      ),
      decoration: _inputDecoration(hint),
    );
  }
}

// =====================================================
// DROPDOWN
// =====================================================

class _DropdownField
    extends StatelessWidget {
  const _DropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFD7E4E0),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 17,
            color: Color(0xFF657570),
          ),
          style: GoogleFonts.inter(
            fontSize: 9,
            color: const Color(0xFF52635F),
          ),
          items: items
              .map(
                (item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
          )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}

// =====================================================
// INPUT DECORATION
// =====================================================

InputDecoration _inputDecoration(
    String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(
      fontSize: 9,
      color: const Color(0xFF9AA7A3),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    border: OutlineInputBorder(
      borderRadius:
      BorderRadius.circular(9),
      borderSide: const BorderSide(
        color: Color(0xFFD7E4E0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius:
      BorderRadius.circular(9),
      borderSide: const BorderSide(
        color: Color(0xFFD7E4E0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius:
      BorderRadius.circular(9),
      borderSide: const BorderSide(
        color: Color(0xFF075E4D),
      ),
    ),
  );
}