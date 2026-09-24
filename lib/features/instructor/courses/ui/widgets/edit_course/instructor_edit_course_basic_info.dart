import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorEditCourseBasicInfo extends StatelessWidget {
  const InstructorEditCourseBasicInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.category,
    required this.level,
    required this.language,
    required this.isEditing,
    required this.onEdit,
    required this.onSave,
    required this.onCategoryChanged,
    required this.onLevelChanged,
    required this.onLanguageChanged,
    required this.isFree,
    required this.onFreeChanged,
    required this.onPickCoverImage,
    this.coverImageUrl = '',
    this.coverImageFile,
    this.isUploadingCoverImage = false,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final String category;
  final String level;
  final String language;

  final bool isEditing;

  final VoidCallback onEdit;
  final VoidCallback onSave;

  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onLevelChanged;
  final ValueChanged<String?> onLanguageChanged;

  final bool isFree;
  final ValueChanged<bool> onFreeChanged;
  final VoidCallback onPickCoverImage;
  final String coverImageUrl;
  final File? coverImageFile;
  final bool isUploadingCoverImage;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.info_outline_rounded,
      title: 'Basic Information',
      subtitle: 'Update your course details.',
      isEditing: isEditing,
      onEdit: onEdit,
      onSave: onSave,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Field(
            label: 'Course Title',
            controller: titleController,
            enabled: isEditing,
          ),

          const SizedBox(height: 14),

          _Field(
            label: 'Description',
            controller: descriptionController,
            enabled: isEditing,
            maxLines: 4,
          ),

          const SizedBox(height: 14),

          Text(
            'Cover Image',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF344540),
            ),
          ),

          const SizedBox(height: 6),

          _CoverImagePicker(
            imageUrl: coverImageUrl,
            imageFile: coverImageFile,
            isUploading: isUploadingCoverImage,
            onTap: onPickCoverImage,
          ),

          const SizedBox(height: 14),

          _Dropdown(
            label: 'Category',
            value: category,
            enabled: isEditing,
            items: const [
              'Development',
              'Design',
              'Business',
              'Marketing',
              'Data Science',
            ],
            onChanged: onCategoryChanged,
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _Dropdown(
                  label: 'Level',
                  value: level,
                  enabled: isEditing,
                  items: const [
                    'Beginner',
                    'Intermediate',
                    'Advanced',
                  ],
                  onChanged: onLevelChanged,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _Dropdown(
                  label: 'Language',
                  value: language,
                  enabled: isEditing,
                  items: const [
                    'English',
                    'Arabic',
                  ],
                  onChanged: onLanguageChanged,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Text(
                'Make this course free',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF344540),
                ),
              ),
              const Spacer(),
              Switch(
                value: isFree,
                onChanged: isEditing ? onFreeChanged : null,
                activeThumbColor: const Color(0xFF075E4D),
              ),
            ],
          ),

          const SizedBox(height: 8),

          _Field(
            label: 'Price',
            controller: priceController,
            enabled: isEditing && !isFree,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

// =============================================================
// COVER IMAGE PICKER
// =============================================================

class _CoverImagePicker extends StatelessWidget {
  const _CoverImagePicker({
    required this.imageUrl,
    required this.imageFile,
    required this.isUploading,
    required this.onTap,
  });

  final String imageUrl;
  final File? imageFile;
  final bool isUploading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final File? local = imageFile;
    final bool hasRemote = imageUrl.trim().isNotEmpty;

    return InkWell(
      onTap: isUploading ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F9F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD3E3DE)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (local != null)
              Image.file(local, fit: BoxFit.cover)
            else if (hasRemote)
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const _Placeholder(),
              )
            else
              const _Placeholder(),
            if (isUploading)
              Container(
                color: Colors.black.withValues(alpha: 0.35),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_outlined, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF263C38),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'PNG, JPG up to 5MB',
          style: GoogleFonts.inter(
            fontSize: 9,
            color: const Color(0xFF899792),
          ),
        ),
      ],
    );
  }
}

// =============================================================
// SECTION CARD
// =============================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isEditing,
    required this.onEdit,
    required this.onSave,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF073F38),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFF84928E),
                      ),
                    ),
                  ],
                ),
              ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: isEditing
                    ? TextButton(
                  key: const ValueKey('save'),
                  onPressed: onSave,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF075E4D),
                    ),
                  ),
                )
                    : IconButton(
                  key: const ValueKey('edit'),
                  onPressed: onEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 34,
                    minHeight: 34,
                  ),
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Color(0xFF075E4D),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }
}

// =============================================================
// TEXT FIELD
// =============================================================

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.enabled,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final bool enabled;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF344540),
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF073F38),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled
                ? Colors.white
                : const Color(0xFFF5F8F7),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E4),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE4ECE9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================
// DROPDOWN
// =============================================================

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.enabled,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final bool enabled;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF344540),
          ),
        ),

        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: enabled ? onChanged : null,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF073F38),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled
                ? Colors.white
                : const Color(0xFFF5F8F7),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E4),
              ),
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}