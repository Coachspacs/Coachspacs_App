class InstructorStudentProgress {
  const InstructorStudentProgress({
    required this.name,
    required this.email,
    required this.initials,
    required this.courseName,
    required this.progress,
    required this.completedLessons,
    required this.totalLessons,
    required this.status,
    required this.enrolledDate,
    required this.lastActive,
    required this.timeSpent,
    required this.quizScores,
  });

  final String name;
  final String email;
  final String initials;
  final String courseName;

  final int progress;
  final int completedLessons;
  final int totalLessons;

  final String status;
  final String enrolledDate;

  final String lastActive;
  final String timeSpent;

  final List<InstructorStudentQuizScore> quizScores;

  bool get canIssueCertificate => progress >= 100;
}

class InstructorStudentQuizScore {
  const InstructorStudentQuizScore({
    required this.title,
    required this.score,
  });

  final String title;
  final int score;
}