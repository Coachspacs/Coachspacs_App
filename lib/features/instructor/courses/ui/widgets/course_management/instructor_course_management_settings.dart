import 'package:flutter/material.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementSettings
    extends StatelessWidget {
  const InstructorCourseManagementSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InstructorManagementSectionCard(
      title: 'Course Settings',
      child: Column(
        children: [
          InstructorSettingRow(
            icon: Icons.visibility_outlined,
            title: 'Course Visibility',
            value: 'Published',
          ),

          InstructorSettingRow(
            icon: Icons.attach_money_rounded,
            title: 'Price',
            value: '\$49.00',
          ),

          InstructorSettingRow(
            icon: Icons.language_outlined,
            title: 'Language',
            value: 'English',
          ),

          InstructorSettingRow(
            icon: Icons.category_outlined,
            title: 'Category',
            value: 'Development',
          ),
        ],
      ),
    );
  }
}