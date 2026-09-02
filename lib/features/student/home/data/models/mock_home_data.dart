import 'category.dart';
import 'course.dart';
import 'home_data.dart';
import 'instructor.dart';
import 'user_profile.dart';

/// Local static mock data for the home screen.
///
/// No backend API exists yet, so the home feature renders purely from these
/// constants. Swap this file for repository/API calls once the backend lands.
abstract final class MockHomeData {
  static const UserProfile currentUser = UserProfile(
    id: 'user-1',
    name: 'Ahmad Mohamed',
    avatarUrl: _userAvatarUrl,
  );

  static const List<Category> categories = [
    Category(
      id: '1',
      name: 'Design',
      slug: 'design',
    ),
    Category(
      id: '2',
      name: 'Development',
      slug: 'development',
    ),
    Category(
      id: '3',
      name: 'Marketing',
      slug: 'marketing',
    ),
    Category(
      id: '4',
      name: 'Business',
      slug: 'business',
    ),
    Category(
      id: '5',
      name: 'Growth',
      slug: 'growth',
    ),
  ];

  static const List<Course> featuredCourses = [
    Course(
      id: 'featured-1',
      title: 'Mastering React and Modern Web Architecture',
      categoryLabel: 'Development',
      instructor: Instructor(
        id: 'instructor-1',
        name: 'Sarah Ahmed',
      ),
      coverImageUrl: _featuredCoverUrl,
      rating: 4.8,
      reviewCount: 120,
      price: 89.00,
    ),
  ];

  static const List<Course> trendingCourses = [
    Course(
      id: 'trending-1',
      title: 'Python for Artificial Intelligence',
      categoryLabel: 'Development',
      instructor: Instructor(
        id: 'instructor-2',
        name: 'Omar Khaled',
      ),
      coverImageUrl: _trendingCodeCoverUrl,
      rating: 4.9,
      reviewCount: 84,
      price: 29.99,
    ),
    Course(
      id: 'trending-2',
      title: 'Complete Digital Marketing',
      categoryLabel: 'Marketing',
      instructor: Instructor(
        id: 'instructor-3',
        name: 'Lina Hassan',
      ),
      coverImageUrl: _trendingMarketingCoverUrl,
      rating: 4.7,
      reviewCount: 210,
      price: 39.99,
    ),
  ];

  static const HomeData aggregate = HomeData(
    categories: categories,
    featuredCourses: featuredCourses,
    trendingCourses: trendingCourses,
  );

  static const String _userAvatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBjZ2QdmV5A55Ew8olaRFQRiQYc8kc4Hk4Xn9rriE0Aj2BC7oBOzRA19cCkzxdaEnpoai0pYQBAUtoNVjCn7XxPkf_tHO645NpUrdg2lEqNo9bivvvF_8llrcbwAKGeBkXwpygPfPGMrF0hmHbqgUzQ1foxw4l_3eSv9HC0JBXoufKCol16uGDY11-axUTEYJYenERPjODjkjUtBw6gADeIrr6vPn2DivE1S3y0MhS0HnkwWQ30rKs';
  static const String _featuredCoverUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuB8AOj_uDWJyUCs88u3ZNacYc6xE2Askha2MYMjXUGPLl14jUnvxafdQ5pvkvuz0kpDQxYpnxQ99oSH1UXhwStl32p18FOsdnGjHOTLHRO1FDZ7PNK8xeg1Hw88Ag76NR926KoSaOiRhT7mG57cl1ACAAF1uCGHbOtachdv0h93rDnqKHT47bhVVdui8VBxlKB0F5mqSARza9EGfyo4LBMTJ55CqB3j9Ub5X9IZhm7Z8kcmW5lPiMM';
  static const String _trendingCodeCoverUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuB8Q8hlsLJyMl_lbMbIg9YNPD2xQJDL3tOY8fTvJD9kuFbfq7hWr7R3awQI2fIWh48v_d8yH41i6nip1gsHclKnEs4_sSs2gyGfhbYUf0aEVPTWSS9exriv00nMZLQclv4kDDU1Ot0hKgqPuZ9w2cNWnDCS6mXN3mXzP2vtkQl5zGECEtxKSNoE6FJQCS8rM4wECdwhdpRHfzTaRnyKlieAOfCsa_oVgN1F0bJgOXA_mlw6gVqeqIg';
  static const String _trendingMarketingCoverUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDivuYje_0g-w-EPuk6pE3IU4XJWEAvfDlS54Ceuc8iauWfSRJo6rneP0b_BfUV9mOfgKyjoS7wkCXYFQuFAfpwWHlEOPojFgyBYCB7ovdv_rwk5WKcgBtCCHL9rTVmdBH0mlM2bA15albz4T0E1nrkpEoltuS8pd6q94lLXo9XKUmli0aUmDk1OKaF71Wmdsb2iTBSEqGfw14mp7PDuVWFPgc6qFC5nfKraCIPR4SGsrj882Lfrlw';
}
