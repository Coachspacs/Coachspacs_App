import 'package:flutter/material.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementContent
    extends StatelessWidget {
  const InstructorCourseManagementContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('01', 'Introduction', '3 lessons'),
      ('02', 'React 19 Essentials', '8 lessons'),
      ('03', 'Next.js App Router Basics', '7 lessons'),
      ('04', 'Data Fetching & Mutations', '9 lessons'),
      ('05', 'Authentication & Authorization', '8 lessons'),
      ('06', 'Deployment & Best Practices', '7 lessons'),
    ];

    return InstructorManagementSectionCard(
      title: 'Course Content',
      trailing: '+ Add Section',
      child: Column(
        children: [
          for (int index = 0;
          index < sections.length;
          index++)
            InstructorContentSection(
              number: sections[index].$1,
              title: sections[index].$2,
              lessons: sections[index].$3,
              showDivider:
              index != sections.length - 1,
            ),
        ],
      ),
    );
  }
}