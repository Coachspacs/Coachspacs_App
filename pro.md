# Coach Space - Project Report

## 1. Overview

**Coach Space** is a Flutter-based Learning Management System (LMS) mobile application serving two roles: **Students** (browse, enroll, complete courses) and **Instructors** (create, manage, track courses and students). It consumes a Django REST Framework backend hosted on Render.

- **Package name:** `coach_space`
- **SDK:** Flutter ^3.12.2
- **Architecture:** Feature-first clean architecture
- **Backend:** `https://coachspace-back.onrender.com/`
- **Languages:** Arabic + English (full localization)

---

## 2. Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/                              # Shared foundation layer
│   ├── auth/                          # Guest session management
│   ├── di/                            # GetIt dependency injection
│   ├── helpers/                       # Context extensions, navigation guards
│   ├── networking/                    # Dio client, interceptors, Retrofit API
│   ├── routing/                       # Named routes + route generator
│   ├── storage/                       # Secure JWT persistence
│   ├── theming/                       # Colors, dimensions, shadows, theme
│   └── widgets/                       # Shared UI components
├── features/
│   ├── auth/                          # Authentication (login, register, verify, reset)
│   ├── onboarding/                    # Onboarding pager (3 pages)
│   ├── signup/                        # Registration screen
│   ├── splash/                        # Splash screen
│   ├── student/                       # Student features
│   │   ├── catalog/                   # Course catalog (browse, search, filter)
│   │   ├── home/                      # Home dashboard
│   │   ├── my_learning/               # Enrolled courses + lesson player
│   │   ├── notifications/             # Notification center
│   │   └── profile/                   # Profile, settings, cart, certificates
│   └── instructor/                    # Instructor features
│       ├── courses/                   # Course CRUD, sections, lessons
│       ├── dashboard/                 # Instructor overview
│       ├── notifications/             # Instructor notifications
│       ├── profile/                   # Instructor profile/settings
│       └── students/                  # Student management + progress
└── l10n/                              # AR/EN localization files
```

**Total screens:** ~40 | **Total Dart files:** 160+

---

## 3. Tech Stack & Dependencies

### Runtime
| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.1.0 | State management (Cubit pattern) |
| `dio` | ^5.7.0 | HTTP client |
| `retrofit` | ^4.10.0 | Type-safe API client (code-gen) |
| `get_it` | ^8.0.3 | Dependency injection |
| `json_annotation` | ^4.9.0 | JSON serialization |
| `flutter_secure_storage` | ^11.0.0 | Encrypted token storage |
| `image_picker` | ^1.2.1 | Camera/gallery image selection |
| `equatable` | ^2.0.7 | Value equality for states |
| `pdf` | ^3.13.0 | PDF certificate generation |
| `printing` | ^5.15.0 | PDF preview/print |
| `google_fonts` | ^6.2.1 | Inter font family |
| `intl` | ^0.20.2 | i18n utilities |

### Dev
| Package | Version | Purpose |
|---------|---------|---------|
| `build_runner` | ^2.4.14 | Code generation |
| `json_serializable` | ^6.9.4 | JSON model generation |
| `retrofit_generator` | ^10.2.9 | Retrofit API generation |
| `flutter_lints` | ^6.0.0 | Lint rules |

---

## 4. State Management

- **Pattern:** Cubit (flutter_bloc) exclusively — no event-based Blocs
- **DI Registration:** GetIt with `LazySingleton` (app-scoped) and `Factory` (per-screen)
- **Cubits:**
  - `AuthCubit` — LazySingleton (app-wide session)
  - `HomeCubit` — Factory (per-screen)
  - `ProfileCubit` — Factory (per-screen)
  - `CatalogCubit` — Factory (per-screen)
- **States:** All use `sealed class` with `Equatable`

### Data Flow
```
UI → Cubit → Repository → ApiService (Retrofit) → Dio → Backend
UI ← Cubit ← Repository ← Network Response
```

---

## 5. API Layer

### HTTP Client Configuration
- **Base URL:** `https://coachspace-back.onrender.com/`
- **Timeouts:** 20s connect/receive/send
- **Interceptors (in order):**
  1. `AcceptLanguageInterceptor` — Injects `Accept-Language` header
  2. `AuthInterceptor` — JWT injection + transparent 401 refresh
  3. `SafeLoggingInterceptor` — Debug-only request logger

### Token Refresh Flow
- On 401: reads refresh token → POSTs to `/api/auth/refresh` → stores new tokens → retries request
- Concurrent 401s deduplicated via `_refreshInFlight`
- On failure: clears session, propagates error

### All Endpoints (34 total)

#### Authentication (9)
| Method | Path | Purpose |
|--------|------|---------|
| POST | `api/auth/login` | User login |
| POST | `api/auth/register` | User registration |
| POST | `api/auth/refresh` | Token refresh |
| POST | `api/auth/logout` | User logout |
| POST | `api/auth/password/forgot` | Request password reset |
| POST | `api/auth/password/reset` | Reset password |
| PUT | `api/auth/password/change` | Change password |
| GET | `api/auth/verify-email` | Verify email (uid+token) |
| POST | `api/auth/verify-email/resend` | Resend verification |

#### User Profile (5)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/users/me` | Get current user |
| PUT | `api/users/me` | Update profile |
| POST | `api/users/me/avatar` | Upload avatar |
| POST | `api/users/me/email/change` | Request email change |
| POST | `api/users/me/email/confirm` | Confirm email change |

#### Catalog (3)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/catalog/categories` | List categories |
| GET | `api/catalog/courses` | List courses (paginated, filterable) |
| GET | `api/catalog/courses/{id}` | Course detail |

#### Enrollments / My Learning (4)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/enrollments` | List enrolled courses |
| GET | `api/enrollments/{id}/lessons/{lessonId}` | Get lesson content |
| POST | `api/enrollments/{id}/lessons/{lessonId}/complete` | Mark lesson complete |
| DELETE | `api/enrollments/{id}/lessons/{lessonId}/complete` | Mark lesson incomplete |

#### Instructor Dashboard (1)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/auth/instructor/dashboard` | Instructor stats |

#### Instructor Courses (10)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/instructor/courses` | List courses |
| POST | `api/instructor/courses` | Create course |
| PATCH | `api/instructor/courses/{id}` | Update course |
| GET | `api/instructor/courses/{id}` | Get course |
| PUT | `api/instructor/courses/{id}` | Replace course |
| DELETE | `api/instructor/courses/{id}` | Delete course |
| POST | `api/instructor/courses/{id}/cover-image` | Upload cover image |
| POST | `api/instructor/courses/{id}/video-upload-signature` | Video upload signature |
| PUT | `api/instructor/courses/{id}/reorder` | Reorder sections |
| POST | `api/instructor/courses/{id}/submit` | Submit for review |

#### Instructor Sections (6)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/instructor/courses/{courseId}/sections` | List sections |
| POST | `api/instructor/courses/{courseId}/sections` | Create section |
| PATCH | `api/instructor/sections/{id}` | Update section |
| GET | `api/instructor/sections/{id}` | Get section |
| PUT | `api/instructor/sections/{id}` | Replace section |
| DELETE | `api/instructor/sections/{id}` | Delete section |

#### Instructor Lessons (6)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/instructor/sections/{sectionId}/lessons` | List lessons |
| POST | `api/instructor/sections/{sectionId}/lessons` | Create lesson |
| PATCH | `api/instructor/lessons/{id}` | Update lesson |
| GET | `api/instructor/lessons/{id}` | Get lesson |
| PUT | `api/instructor/lessons/{id}` | Replace lesson |
| DELETE | `api/instructor/lessons/{id}` | Delete lesson |

#### Media (1)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `api/media/stream` | Stream media content |

---

## 6. Authentication Flow

```
App Start → setupLocator() → AuthCubit.restoreSession()
                                    │
                        ┌───────────┼───────────┐
                        │           │           │
                   No session   Authenticated  Pending
                        │           │           │
                    Onboarding   Role-based    Pending
                        │        routing       Approval
                    Login/Signup     │         Screen
                              ┌─────┼─────┐
                              │     │     │
                          Student  Inst.  Inst.
                                   approved pending
```

- **Registration** → Email verification (external link) → Login
- **Login** → JWT access+refresh tokens → Encrypted storage
- **401** → Transparent refresh → Retry original request
- **Guest mode** → Browse home only, login dialog for protected routes

---

## 7. Navigation

- **System:** Navigator 1.0 with named routes
- **Route definitions:** `lib/core/routing/routes.dart` (30+ routes)
- **Route generator:** `lib/core/routing/app_router.dart` (231 lines)
- **Auth gate:** `BlocListener<AuthCubit>` above Navigator forces navigation on state change

### Bottom Navigation
| Role | Tabs |
|------|------|
| Student | Home, Catalog, My Learning, Profile |
| Instructor | Dashboard, Courses, Students, Profile |

---

## 8. Models

### Auth (17 DTO files)
`LoginRequest/Response`, `RegisterRequest/Response`, `RefreshTokenRequest/Response`, `LogoutRequest`, `ForgotPasswordRequest`, `ResetPasswordRequest`, `ChangePasswordRequest`, `ResendVerificationRequest`, `UserSession`, `UserRole` (enum), `ApprovalStatus` (enum)

### Student Features
- **Home:** `HomeData`, `Category`, `Course`, `Instructor`, `MockHomeData`
- **Catalog:** `CatalogCourseDto`, `CourseDetailDto`, `CourseSectionDto`, `CourseLessonDto`, `CategoryDto`
- **Enrollments:** `EnrollmentDto`, `EnrollmentCourseDto`, `LessonPlayerDto`
- **Profile:** `UserProfileModel`, `UpdateProfileRequest`, `ChangeEmailRequest`, `ConfirmEmailChangeRequest`

### Instructor Features
- **Courses:** `InstructorCourseDto`, `InstructorSectionDto`, `InstructorLessonDto`, `CourseWriteRequest`, `CoursePatchRequest`, `SectionWriteRequest/ReorderRequest`, `LessonWriteRequest/LessonPatchRequest`
- **Students:** `InstructorStudentProgress`

### Shared
- `AppNotification`, `NotificationType` (enum), `PaginatedResponse<T>`

---

## 9. Localization

- **Template:** `lib/l10n/app.ar.arb` (Arabic)
- **Translations:** `lib/l10n/app_en.arb` (English)
- **Generated:** `app_localizations.dart`, `app_localizations_ar.dart`, `app_localizations_en.dart`
- **~80+ keys** covering auth, home, signup, settings, verification flows
- **Accept-Language header** injected via interceptor

---

## 10. Key Issues & Recommendations

### Critical
1. **Mock data in production screens** — Home, CourseDetails, Cart, Checkout, OrderHistory, Certificates, Dashboard, and all settings screens use hardcoded mock data instead of API calls.
2. **No Cubit in many screens** — MyLearning, BrowseCourses, Cart, Checkout, OrderHistory, Certificates, ProfileInformation, LearningSettings, SecuritySettings, PreferencesSettings, ContactUs lack state management.
3. **Payment not implemented** — Checkout screen is entirely static with no payment gateway.

### High
4. **Catalog filters not sent to API** — Client-side filtering only.
5. **Sort non-functional** — Sort bottom sheet has no implementation.
6. **CourseDetailsScreen has no API call** — `CatalogRepository.getCourse()` exists but is never invoked.
7. **Notifications are in-memory only** — Lost on app restart.

### Medium
8. **Hardcoded strings** — Many success screens have non-localized strings.
9. **No pull-to-refresh** — Home, MyLearning, BrowseCourses, Catalog lack pull-to-refresh.
10. **Swallowed errors** — MyLearning catches and ignores enrollment load failures.
11. **Guest mode incomplete** — Login dialog shown but no actual guest data loading.

### Low
12. **Duplicate ProfileCubit creation** — SettingsScreen creates its own instead of reusing.
13. **SectionHeader uses string comparison** for conditional styling.
14. **DashboardScreen navigation bug** — Profile button pops instead of navigating.

---

## 11. Sprint Status

| Sprint | Status |
|--------|--------|
| Sprint 0 (Foundation) | ✅ Complete |
| Sprint 1 (Auth + Onboarding) | 🔄 In Progress |
| Sprint 2 (Student Features) | ⏳ Pending |
| Sprint 3 (Instructor Features) | ⏳ Pending |
| Sprint 4 (Polish + Testing) | ⏳ Pending |

---

## 12. Repository & DI Summary

### Repositories (Abstract → Impl)
| Repository | Features |
|-----------|----------|
| `AuthRepository` | Login, register, refresh, logout, password, verify |
| `HomeRepository` | Categories, mock courses |
| `CatalogRepository` | Catalog courses, course detail, categories |
| `ProfileRepository` | Get/update profile, avatar, email change |
| `EnrollmentRepository` | Enrollments, lesson access, completion |
| `InstructorCoursesRepository` | Full CRUD for courses/sections/lessons |

### DI Registration (`injection_container.dart`)
- `ApiService` — LazySingleton
- `SessionStorage` — LazySingleton
- `AuthCubit` — LazySingleton
- `HomeCubit` — Factory
- `ProfileCubit` — Factory
- `CatalogCubit` — Factory
- All Repositories — LazySingleton

---

*Report generated for Coach Space Flutter project.*
