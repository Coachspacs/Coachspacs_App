# Coach Space - Student-Facing Screens Report

## Table of Contents
1. [Home Screen](#1-home-screen)
2. [Catalog Screen](#2-catalog-screen)
3. [Course Details Screen](#3-course-details-screen)
4. [My Learning Screen](#4-my-learning-screen)
5. [Profile Screen](#5-profile-screen)
6. [Dashboard Screen](#6-dashboard-screen)
7. [Browse Courses Screen](#7-browse-courses-screen)
8. [Cart Screen](#8-cart-screen)
9. [Checkout Screen](#9-checkout-screen)
10. [Order History Screen](#10-order-history-screen)
11. [Certificates Screen](#11-certificates-screen)
12. [Profile Information Screen](#12-profile-information-screen)
13. [Contact Us Screen](#13-contact-us-screen)
14. [Settings Screen](#14-settings-screen)
15. [Learning Settings Screen](#15-learning-settings-screen)
16. [Security Settings Screen](#16-security-settings-screen)
17. [Preferences Settings Screen](#17-preferences-settings-screen)
18. [Notification Screen](#18-notification-screen)
19. [Endpoint Summary](#endpoint-summary)
20. [Cross-Cutting Issues](#cross-cutting-issues)

---

## 1. Home Screen

**File:** `lib/features/student/home/ui/screens/home_screen.dart`
**Cubit:** `HomeCubit` → `HomeRepository`

### Purpose
Main student dashboard showing welcome message, streak, continue learning card, categories, and recommended courses.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/catalog/categories` | ✅ Implemented |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | `featuredCourses` and `trendingCourses` come from `MockHomeData`, not from any API endpoint. Repository explicitly states "no course endpoints exist on the backend yet." |
| 2 | 🔴 Critical | `ContinueLearningCard` is fully hardcoded: "PRODUCT STRATEGY & LEADERSHIP", "Lesson 7 of 11", "Dr. Elena Rostova", "65% completed", "22 mins remaining" — none tied to real enrollment data. |
| 3 | 🔴 Critical | `StreakCard` is fully hardcoded: "3-Day Streak!", "Personal best: 7 days", "80%" — no streak API exists. |
| 4 | 🟡 Medium | Success view strings ('Continue Learning', 'Top Categories', 'Recommended Courses', 'See all') are not localized. |
| 5 | 🟡 Medium | Hardcoded colors (`Color(0xFFF7FAF9)`, `Color(0xFF073F38)`) appear instead of using theme tokens. |
| 6 | 🟡 Medium | No pull-to-refresh on the success view. |
| 7 | 🟢 Low | `SectionHeader` uses string comparison (`title == 'Continue Learning'`) for styling — fragile, should use a flag or separate widget. |

### Expected Endpoints (Not Implemented)
- `GET /api/student/dashboard` or `GET /api/home` — should return featured courses, trending courses, streak data, continue learning progress.

---

## 2. Catalog Screen

**File:** `lib/features/student/catalog/ui/screens/catalog_screen.dart`
**Cubit:** `CatalogCubit` → `CatalogRepository`

### Purpose
Browse and filter courses from the public catalog with search, category, level, language, and price filters.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/catalog/courses` | ✅ Implemented (page 1, pageSize 50 only) |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | Categories list is hardcoded: `['All', 'Design', 'Development', 'Business', 'Marketing', 'Data Science']` — not fetched from `GET /api/catalog/categories`. |
| 2 | 🔴 Critical | Filters (language, level, price) are stored in local state but **never sent to the API** — cubit's `load()` is never re-called with updated params. Filtering is client-side only. |
| 3 | 🔴 Critical | Sort bottom sheet is non-functional — `_SortOption.onTap` just pops the sheet with no sorting logic. |
| 4 | 🟡 Medium | Rating and student count always display as '—' because `CatalogCourseDto` doesn't expose these fields. |
| 5 | 🟡 Medium | Pagination not implemented — always loads `page: 1, pageSize: 50`. No infinite scroll or load-more. |
| 6 | 🟢 Low | `CatalogCubit` is manually created and disposed (not using BlocProvider) — inconsistent with other screens. |

### Expected Endpoints (Not Implemented)
- Server-side filtering via API query params when filters change.
- Server-side sorting.
- Pagination beyond page 1.

---

## 3. Course Details Screen

**File:** `lib/features/student/catalog/ui/screens/course_details_screen.dart`
**Cubit:** None

### Purpose
Display full details for a single course: hero image, instructor, curriculum, includes, and purchase options.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/catalog/courses/{id}` | ❌ Not called (endpoint exists but unused) |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | No API call — screen receives data purely via `ModalRoute.arguments`. `CatalogRepository.getCourse(int id)` exists but is **never invoked**. |
| 2 | 🔴 Critical | `CourseDetailsCurriculum` is 100% hardcoded: 3 sections with 9 lessons, all static strings — not fetched from API. |
| 3 | 🔴 Critical | "Buy Now" button is a no-op (`onPressed: () {}`). Comment says "Add the real purchase logic here later." |
| 4 | 🔴 Critical | "Add to Cart" only shows a local dialog and adds a notification — no API call to actually add to cart. |
| 5 | 🔴 Critical | No enrollment check — if user already owns the course, the purchase card still shows. |
| 6 | 🟡 Medium | Hardcoded default values if no arguments: "Next.js 15 & React 19 Fullstack Masterclass", "Dr. Tareq Al-Mansoor", "$89.00", "4.9", "2.4k". |
| 7 | 🟡 Medium | Strikethrough original price hardcoded as `$119.00`. |
| 8 | 🟡 Medium | `CourseDetailsIncludes` and `CourseDetailsInstructorCard` are hardcoded. |
| 9 | 🟡 Medium | Data mismatch: Home passes a `Course` object; Catalog passes a `Map<String, dynamic>` — fragile pattern. |

### Expected Endpoints (Not Implemented)
- `GET /api/catalog/courses/{id}` — fetch full course details (curriculum, instructor bio, includes, enrollment status)
- `POST /api/cart/items` — add course to cart
- `POST /api/checkout` or `POST /api/orders` — purchase course
- Enrollment status check

---

## 4. My Learning Screen

**File:** `lib/features/student/my_learning/ui/screens/my_learning_screen.dart`
**Cubit:** None (uses `EnrollmentRepository` directly)

### Purpose
Student's enrolled courses dashboard with stats, continue learning section, courses list, certificates, and recent activity.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/enrollments` | ✅ Implemented (page 1, pageSize 50) |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | No Cubit/BLoC — uses direct repository call in `initState` with `setState`. Inconsistent with architecture. |
| 2 | 🔴 Critical | `MyCertificatesSection` is hardcoded: "Full-Stack Development" with "Certificate earned" — not from API. |
| 3 | 🔴 Critical | `RecentActivitySection` is 100% hardcoded: "Completed Lesson 11", "Started Lesson 12", "Earned a certificate" — all static mock data. |
| 4 | 🟡 Medium | Errors are silently swallowed: `catch (_) { // Keep the screen usable if the optional request fails. }` — user gets no feedback. |
| 5 | 🟡 Medium | Guest check is redundant — checks `GuestSession.isGuest` in both `initState` and `build`. |
| 6 | 🟡 Medium | No pull-to-refresh. |

### Expected Endpoints (Not Implemented)
- `GET /api/enrollments/{id}/activity` — activity feed
- `GET /api/certificates` — earned certificates
- Pull-to-refresh support

---

## 5. Profile Screen

**File:** `lib/features/student/profile/ui/screens/profile_screen.dart`
**Cubit:** `ProfileCubit` → `ProfileRepository`

### Purpose
Student profile menu with navigation to settings, orders, cart, certificates, and contact.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/users/me` | ✅ Implemented |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🟡 Medium | Menu item strings ('Account Settings', 'Order History', 'My Cart', 'Certificates', 'Contact us') are not localized. |
| 2 | 🟡 Medium | No loading state handling — when `ProfileCubit` emits `ProfileLoading`, defaults to "Student"/"Student" with no visual indicator. |
| 3 | 🟡 Medium | `ProfileLoadFailure` not handled — profile load failure shows defaults without error indication. |
| 4 | 🟢 Low | Logout uses `GuestSession.logout()` instead of `ProfileCubit` — `ProfileCubit` has no logout method. |

### Expected Endpoints
- Already implemented via `GET /api/users/me`. Localization is the main gap.

---

## 6. Dashboard Screen

**File:** `lib/features/student/profile/ui/screens/dashboard_screen.dart`
**Cubit:** None

### Purpose
Alternative/legacy profile dashboard showing stats, continue learning, and certificates.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded mock data: `userName: 'Hadeel Baroud'`, stats "3 courses", "1 earned", "38.5 hrs", course title "React 19 & Next.js App Router Masterclass". |
| 2 | 🔴 Critical | No Cubit, no API integration at all. |
| 3 | 🟡 Medium | Navigation bug: `onProfilePressed` calls `Navigator.pop(context)` instead of navigating to profile. |
| 4 | 🟡 Medium | `ContinueLearningCard.onPressed` navigates to `browseCourses` — not to the actual course player. |

### Expected Endpoints (Not Implemented)
- Entire screen needs API integration for real stats, real course data, real activity.

---

## 7. Browse Courses Screen

**File:** `lib/features/student/profile/ui/screens/browse_courses_screen.dart`
**Cubit:** None (uses `EnrollmentRepository` directly)

### Purpose
List of enrolled courses with filter tabs (All / In Progress / Completed).

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/enrollments` | ✅ Implemented |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | `_openCourseDetails` passes **no arguments** to `CourseDetailsScreen` — will always show hardcoded defaults. |
| 2 | 🟡 Medium | No Cubit — direct repository call in `initState`, inconsistent with architecture. |
| 3 | 🟡 Medium | Error message is hardcoded: `'Unable to load your courses.'`. |
| 4 | 🟡 Medium | No pull-to-refresh. |

### Expected Endpoints (Not Implemented)
- Pass course ID/details to `CourseDetailsScreen`.

---

## 8. Cart Screen

**File:** `lib/features/student/profile/ui/screens/cart_screen.dart`
**Cubit:** None

### Purpose
Shopping cart view showing items, subtotal, and checkout button.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded mock data: `$89.00` price, `'1 item'`, "Next.js 15 & React 19 Fullstack Masterclass", "Dr. Tareq Al-Mansoor". |
| 2 | 🔴 Critical | No Cubit/Repository — cart items not fetched from any API. |
| 3 | 🟡 Medium | Remove action is local-only — shows SnackBar but doesn't remove from any data store. |
| 4 | 🟢 Low | No cart badge/counter integration with bottom nav. |

### Expected Endpoints (Not Implemented)
- `GET /api/cart` — fetch cart items
- `DELETE /api/cart/items/{id}` — remove item from cart
- Cart count for bottom nav badge

---

## 9. Checkout Screen

**File:** `lib/features/student/profile/ui/screens/checkout_screen.dart`
**Cubit:** None

### Purpose
Payment/checkout flow with billing info, payment method, coupon, and order summary.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded mock data: `$89.00` price, course name, instructor name, `'sondos@example.com'` email, `'Palestine'` billing country. |
| 2 | 🔴 Critical | No payment processing — Pay button `onPressed` is a no-op (`onPressed: () {}`). |
| 3 | 🔴 Critical | No Cubit/Repository. |
| 4 | 🟡 Medium | Coupon apply is fake — just shows a SnackBar, doesn't validate or apply anything. |
| 5 | 🟡 Medium | No form validation on card fields. |
| 6 | 🟡 Medium | Discount and taxes hardcoded to `$0.00`. |
| 7 | 🟡 Medium | Security concern: CVV field exists but no real payment gateway integration. |

### Expected Endpoints (Not Implemented)
- Payment gateway integration (Stripe, etc.)
- `POST /api/checkout` — process payment
- `POST /api/coupons/validate` — validate coupon code
- Dynamic cart data and pricing

---

## 10. Order History Screen

**File:** `lib/features/student/profile/ui/screens/order_history_screen.dart`
**Cubit:** None

### Purpose
Display past orders with order number, date, items, total, and status.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded mock data: 12 orders with hardcoded numbers (#CS-7721, etc.), dates, items, totals, and statuses. |
| 2 | 🔴 Critical | No Cubit/Repository. |
| 3 | 🟡 Medium | Export button is a no-op (`onExport: () {}`). |
| 4 | 🟡 Medium | Order tap is a no-op (`onTap: () {}`, `onOrderPressed: (order) {}`). |

### Expected Endpoints (Not Implemented)
- `GET /api/orders?page=X&pageSize=Y` — fetch real order history
- Order detail view
- Export functionality

---

## 11. Certificates Screen

**File:** `lib/features/student/profile/ui/screens/certificates_screen.dart`
**Cubit:** None

### Purpose
Display earned certificates with PDF download capability.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded mock data: "Building Professional UI/UX Design Systems with Figma", "CERT-892401", "Sondos Abu Skhail", "May 12, 2024", "Dr. Tareq Al-Mansoor". |
| 2 | 🔴 Critical | Only shows one certificate — no list of multiple certificates. |
| 3 | 🔴 Critical | No Cubit/Repository. |

### Expected Endpoints (Not Implemented)
- `GET /api/certificates` — fetch all earned certificates

---

## 12. Profile Information Screen

**File:** `lib/features/student/profile/ui/screens/profile_information_screen.dart`
**Cubit:** None (despite `ProfileCubit` existing with relevant methods)

### Purpose
Edit profile info: name, email, phone, headline, and avatar.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | 100% hardcoded initial data: name `'sondos abu skhail'`, email `'abuskhailsondos@gmail.com'`. |
| 2 | 🔴 Critical | Save button is fake — shows "Changes saved" SnackBar, doesn't call any API. |
| 3 | 🔴 Critical | Avatar upload button has no `onPressed` handler — non-functional. |
| 4 | 🟡 Medium | "Change" email link not connected to `ProfileCubit.requestEmailChange()`. |
| 5 | 🟡 Medium | Does not use `ProfileCubit` which already has `loadProfile()`, `saveProfile()`, `uploadAvatar()`, `requestEmailChange()`. |
| 6 | 🟡 Medium | No form validation on name field. |

### Expected Endpoints (Not Implemented)
- Use `ProfileCubit` for loading/saving profile via `GET /api/users/me` and `PUT /api/users/me`
- Avatar upload via `POST /api/users/me/avatar`
- Email change via `POST /api/users/me/email/change` + `POST /api/users/me/email/confirm`

---

## 13. Contact Us Screen

**File:** `lib/features/student/profile/ui/screens/contact_us_screen.dart`
**Cubit:** None

### Purpose
Contact form to send support messages.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | API integration missing — comment explicitly says `// API integration will be added later.` |
| 2 | 🟡 Medium | Send button shows fake success — always shows "Your message has been sent successfully" regardless. |
| 3 | 🟡 Medium | No subject/category selection — only a message textarea. |
| 4 | 🟡 Medium | No loading state while "sending." |

### Expected Endpoints (Not Implemented)
- `POST /api/support/messages` or `POST /api/contact` — send contact form

---

## 14. Settings Screen

**File:** `lib/features/student/profile/ui/screens/settings_screen.dart`
**Cubit:** `ProfileCubit` → `ProfileRepository`

### Purpose
Account settings hub linking to profile info, learning settings, security, and preferences.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| `GET /api/users/me` | ✅ Implemented |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🟡 Medium | Creates its own `ProfileCubit` separate from `ProfileScreen`'s cubit — may cause duplicate API calls if both screens are in the same navigation stack. |
| 2 | 🟢 Low | No error handling if profile load fails. |

### Expected Endpoints
- Already implemented via `GET /api/users/me`.

---

## 15. Learning Settings Screen

**File:** `lib/features/student/profile/ui/screens/learning_settings_screen.dart`
**Cubit:** None

### Purpose
Learning preferences: goal, field of interest, certificate name, playback speed, public profile toggle.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | All data is hardcoded: goal, name, field, speed, public profile. |
| 2 | 🔴 Critical | Save button is fake — shows SnackBar, doesn't persist anything. |
| 3 | 🔴 Critical | No Cubit/Repository. |

### Expected Endpoints (Not Implemented)
- `GET /api/users/me/settings` — fetch learning settings
- `PUT /api/users/me/settings` — save learning settings

---

## 16. Security Settings Screen

**File:** `lib/features/student/profile/ui/screens/security_settings_screen.dart`
**Cubit:** None

### Purpose
Password change form with current password, new password, and confirm password fields.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | No API call — password change is client-side validation only (checks non-empty + match). |
| 2 | 🟡 Medium | Does not validate current password against the server. |
| 3 | 🟡 Medium | No minimum password length check. |
| 4 | 🟡 Medium | Save button shows fake success. |

### Expected Endpoints (Not Implemented)
- `PUT /api/auth/password/change` — change password via API (endpoint exists in `ApiService` but is not called from this screen)

---

## 17. Preferences Settings Screen

**File:** `lib/features/student/profile/ui/screens/preferences_settings_screen.dart`
**Cubit:** None

### Purpose
Notification preferences and language selection.

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | All data is local state — toggles and language selection are not persisted. |
| 2 | 🔴 Critical | Save button is fake. |
| 3 | 🟡 Medium | Language dropdown doesn't actually change app language — just updates local state. |
| 4 | 🟡 Medium | No Cubit/Repository. |

### Expected Endpoints (Not Implemented)
- `GET /api/users/me/preferences` — fetch preferences
- `PUT /api/users/me/preferences` — save preferences
- Actual locale switching integration

---

## 18. Notification Screen

**File:** `lib/features/student/notifications/ui/screens/notification_screen.dart`
**Cubit:** None (uses `NotificationService` with `ValueNotifier`)

### Purpose
Display notifications grouped by "Today" and "Earlier."

### API Endpoints Used
| Endpoint | Status |
|----------|--------|
| None | ❌ No API calls |

### Issues
| # | Severity | Issue |
|---|----------|-------|
| 1 | 🔴 Critical | All notifications are hardcoded in `NotificationService`: only 2 sample notifications ("Course Approved!", "Platform Update"). |
| 2 | 🔴 Critical | No API integration — notifications are in-memory only, lost on app restart. |
| 3 | 🟡 Medium | "Today" vs "Earlier" split is naive: uses `take(3)` for today and `skip(3)` for earlier — not based on actual timestamps. |
| 4 | 🟡 Medium | No Cubit — uses `ValueNotifier` directly, inconsistent with architecture. |

### Expected Endpoints (Not Implemented)
- `GET /api/notifications` — fetch notifications from server
- Push notification integration (FCM/APNs)
- Notification persistence

---

## Endpoint Summary

### Existing Endpoints Used by Student Screens

| Endpoint | Screen(s) | Status |
|----------|-----------|--------|
| `GET /api/catalog/categories` | HomeScreen | ✅ Called |
| `GET /api/catalog/courses` | CatalogScreen | ✅ Called |
| `GET /api/enrollments` | MyLearningScreen, BrowseCoursesScreen | ✅ Called |
| `GET /api/users/me` | ProfileScreen, SettingsScreen | ✅ Called |

### Existing Endpoints NOT Used by Student Screens

| Endpoint | Should Be Used By | Status |
|----------|-------------------|--------|
| `GET /api/catalog/courses/{id}` | CourseDetailsScreen | ❌ Not called |
| `PUT /api/auth/password/change` | SecuritySettingsScreen | ❌ Not called |

### Expected Endpoints (Not Implemented Backend)

| Endpoint | Screen(s) | Priority |
|----------|-----------|----------|
| `GET /api/student/dashboard` | HomeScreen | 🔴 High |
| `POST /api/cart/items` | CourseDetailsScreen | 🔴 High |
| `GET /api/cart` | CartScreen | 🔴 High |
| `DELETE /api/cart/items/{id}` | CartScreen | 🔴 High |
| `POST /api/checkout` | CheckoutScreen | 🔴 High |
| `GET /api/orders` | OrderHistoryScreen | 🔴 High |
| `GET /api/certificates` | CertificatesScreen | 🔴 High |
| `GET /api/notifications` | NotificationScreen | 🔴 High |
| `POST /api/support/messages` | ContactUsScreen | 🟡 Medium |
| `GET /api/users/me/settings` | LearningSettingsScreen | 🟡 Medium |
| `PUT /api/users/me/settings` | LearningSettingsScreen | 🟡 Medium |
| `GET/PUT /api/users/me/preferences` | PreferencesSettingsScreen | 🟡 Medium |
| `POST /api/coupons/validate` | CheckoutScreen | 🟡 Medium |
| `GET /api/enrollments/{id}/activity` | MyLearningScreen | 🟢 Low |

---

## Cross-Cutting Issues

### 1. Mock Data (Critical)
**Affected screens:** Home, CourseDetails, Dashboard, Cart, Checkout, OrderHistory, Certificates, ProfileInformation, LearningSettings, RecentActivity, StreakCard, ContinueLearningCard, Notifications

Nearly half the student screens display hardcoded mock data instead of fetching from the API.

### 2. Missing State Management (Critical)
**Affected screens:** MyLearning, BrowseCourses, Cart, Checkout, OrderHistory, Certificates, ProfileInformation, LearningSettings, SecuritySettings, PreferencesSettings, ContactUs

These screens use direct repository calls or no repository at all, inconsistent with the Cubit-based architecture used elsewhere.

### 3. Fake Save/Submit Buttons (High)
**Affected screens:** ProfileInformation, LearningSettings, SecuritySettings, PreferencesSettings, ContactUs, Cart, Checkout

Buttons show success SnackBars without actually calling any API.

### 4. Hardcoded Strings (Medium)
**Affected screens:** Home (success view), Catalog, Profile menu, all settings screens

Many UI strings are not passed through the localization system.

### 5. No Pull-to-Refresh (Medium)
**Affected screens:** Home, MyLearning, BrowseCourses, Catalog

Users cannot manually refresh data on these screens.

### 6. Missing Error Handling (Medium)
**Affected screens:** MyLearning (swallowed errors), Profile (no failure state), BrowseCourses

Errors are either silently ignored or not displayed to the user.

### 7. Navigation Issues (Medium)
- BrowseCourses → CourseDetails passes no arguments
- DashboardScreen profile button pops instead of navigating
- CourseDetailsScreen data mismatch between Home (Course object) and Catalog (Map)

---

*Report generated for Coach Space student-facing screens.*
