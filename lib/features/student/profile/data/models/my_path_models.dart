import 'package:flutter/material.dart';

class MyPathOption {
  final int id;
  final IconData icon;
  final String title;
  final String description;
  final String? badge;
  final String? recommendedText;
  final String? activeText;
  final bool recommended;
  final String? skipText;
  final String? savesText;

  const MyPathOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    this.badge,
    this.recommendedText,
    this.activeText,
    this.recommended = false,
    this.skipText,
    this.savesText,
  });
}

class MyPathSkillOption {
  final int id;
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final bool popular;

  const MyPathSkillOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    this.popular = false,
  });
}

abstract final class MyPathGoalOptionsData {
  static const List<MyPathOption> all = [
    MyPathOption(
      id: 0,
      icon: Icons.business_center_outlined,
      title: 'Get a new job / career change',
      description:
          'Transition into high-demand roles with personalized roadmaps',
      badge: 'Popular',
    ),
    MyPathOption(
      id: 1,
      icon: Icons.trending_up_rounded,
      title: 'Improve my current skills',
      description: 'Deepen domain expertise and master contemporary frameworks',
      recommendedText: 'Recommended: ~6 wks path',
      activeText: 'Active Selection',
    ),
    MyPathOption(
      id: 2,
      icon: Icons.school_outlined,
      title: 'Prepare for an exam',
      description:
          'Structured mock tests, speed-quizzes, and accredited certifications',
    ),
    MyPathOption(
      id: 3,
      icon: Icons.auto_awesome_outlined,
      title: 'Learn for personal growth',
      description: 'Explore creative passions and intellectually stimulating topics',
    ),
    MyPathOption(
      id: 4,
      icon: Icons.more_horiz_rounded,
      title: 'Other / Custom Journey',
      description: 'Customized pace or unique cross-disciplinary objectives',
    ),
  ];
}

abstract final class MyPathLevelOptionsData {
  static const List<MyPathOption> all = [
    MyPathOption(
      id: 0,
      icon: Icons.menu_book_outlined,
      title: 'Beginner (From Scratch)',
      description: 'Starting from the beginning with no prior knowledge',
    ),
    MyPathOption(
      id: 1,
      icon: Icons.code_rounded,
      title: 'Basic Knowledge',
      description: 'Familiar with general concepts, need hands-on practice',
    ),
    MyPathOption(
      id: 2,
      icon: Icons.trending_up_rounded,
      title: 'Intermediate',
      description: 'Practical experience, looking to build solid projects',
      recommended: true,
    ),
    MyPathOption(
      id: 3,
      icon: Icons.bookmark_rounded,
      title: 'Advanced',
      description: 'Strong experience, looking to master complex topics',
      skipText: 'Skips foundational intro modules',
      savesText: 'Saves ~18 hrs',
    ),
  ];
}

abstract final class MyPathSkillOptionsData {
  static const List<MyPathSkillOption> all = [
    MyPathSkillOption(
      id: 0,
      icon: Icons.code,
      title: 'Frontend Web Development',
      description:
          'Build interactive, high-performance user interfaces and responsive web apps.',
      tags: ['React', 'Next.js', 'TypeScript'],
      popular: true,
    ),
    MyPathSkillOption(
      id: 1,
      icon: Icons.edit_outlined,
      title: 'UI/UX & Product Design',
      description:
          'Design user-centric digital products, design systems, and rapid interactive prototypes.',
      tags: ['Figma', 'Design Systems', 'User Research'],
    ),
    MyPathSkillOption(
      id: 2,
      icon: Icons.storage_outlined,
      title: 'Backend & Cloud Architecture',
      description:
          'Scalable APIs, distributed microservices, and modern database management.',
      tags: ['Node.js', 'Python', 'AWS'],
    ),
    MyPathSkillOption(
      id: 3,
      icon: Icons.bolt_outlined,
      title: 'AI & Data Science',
      description:
          'Harness LLMs, machine learning pipelines, and predictive data insights.',
      tags: ['Python', 'TensorFlow', 'Pandas'],
    ),
  ];
}
