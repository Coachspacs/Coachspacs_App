import 'package:flutter/material.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementStudents
    extends StatelessWidget {
  const InstructorCourseManagementStudents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final students = [
      ('Sara Ali', '65%', '2 days ago'),
      ('Omar Hassan', '40%', '3 days ago'),
      ('Lina Mohammed', '90%', '5 days ago'),
      ('Youssef Ahmed', '30%', '1 week ago'),
    ];

    return InstructorManagementSectionCard(
      title: 'Recent Students',
      trailing: 'View All',
      child: Column(
        children: [
          for (int index = 0;
          index < students.length;
          index++)
            InstructorStudentManagementRow(
              name: students[index].$1,
              progress: students[index].$2,
              enrolled: students[index].$3,
              showDivider:
              index != students.length - 1,
            ),
        ],
      ),
    );
  }
}