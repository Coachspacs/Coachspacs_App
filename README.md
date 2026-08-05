<p align="center">
  <img src="assets/images/logo.png" alt="Coach Space Logo" width="120"/>
</p>

<h1 align="center">Coach Space</h1>

<p align="center">
  <strong>A General-Purpose E-Learning Platform — Mobile App</strong>
  <br />
  Built with Flutter. Scale-ready. Production-grade.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.12-02569B?style=for-the-badge&logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.12-0175C2?style=for-the-badge&logo=dart" alt="Dart"/>
  <img src="https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge" alt="Status"/>
  <img src="https://img.shields.io/badge/License-MIT-4CAF50?style=for-the-badge" alt="License"/>
  <img src="https://img.shields.io/badge/SDK-%5E3.12.2-00599C?style=for-the-badge" alt="SDK"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/State%20Management-Bloc%20%7C%20Cubit-EC407A?style=flat-square&logo=bloc" alt="State Management"/>
  <img src="https://img.shields.io/badge/Networking-Dio%20%7C%20Retrofit-1565C0?style=flat-square&logo=dart" alt="Networking"/>
  <img src="https://img.shields.io/badge/DI-GetIt-FF6F00?style=flat-square" alt="DI"/>
  <img src="https://img.shields.io/badge/Codegen-Build%20Runner-6A1B9A?style=flat-square" alt="Codegen"/>
</p>

<br/>

---

## Overview

Coach Space is a **general-purpose Learning Management System (LMS)** — not tied to any specific domain — built as a clean, reusable core product. This mobile application, developed in **Flutter**, delivers a native experience for both **students** and **instructors** on Android and iOS, consuming a unified REST API.

Designed for scalability and maintainability, the app follows a **feature-first architecture** with a shared core layer, ensuring clean separation of concerns and long-term extensibility.

<br/>

---

## Key Features

### For Students

<p align="center">
  <img src="https://via.placeholder.com/800x400/1a1a2e/e94560?text=Student+Dashboard+Preview" alt="Student Dashboard Preview" width="80%"/>
</p>

| Feature | Description |
|---------|-------------|
| 🔐 **Authentication** | Register and log in securely using JWT-based authentication with access and refresh tokens |
| 🌍 **Bilingual UI** | Full Arabic and English support with automatic RTL/LTR layout switching |
| 📚 **Course Browsing** | Discover courses with search, filtering (by category, level, price, language), and pagination |
| 📖 **Course Details** | View comprehensive course information, curriculum breakdown, and preview content |
| 🛒 **Cart & Checkout** | Add courses to cart, manage selections, and complete a streamlined mock checkout |
| 🆓 **Free Enrollment** | Enroll directly in free courses with a single tap — no checkout required |
| 📊 **Learning Dashboard** | Track all enrolled courses with real-time progress indicators |
| ▶️ **Lesson Player** | Watch video lessons with smooth playback and seamless section navigation |
| ✅ **Progress Tracking** | Mark lessons as complete and watch your course progress update instantly |
| 📜 **Certificates** | Automatically receive a PDF certificate upon 100% course completion |

<br/>

### For Instructors

| Feature | Description |
|---------|-------------|
| 👤 **Instructor Registration** | Register with a pending-approval workflow, managed via the admin panel |
| 📈 **Instructor Dashboard** | Overview of your courses, enrolled students, and performance metrics |
| ✏️ **Course Creation** | Build courses with rich metadata: title, description, category, level, language, price, and cover image |
| 📝 **Content Management** | Organize courses into sections and lessons with video content |
| 🔄 **Review Workflow** | Submit courses for admin review and track approval status with rejection feedback |
| 👥 **Student Management** | View the list of enrolled students and their progress per course |

<br/>

---

## Tech Stack

<p align="center">
  <img src="https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart" alt="Dart"/>
  <img src="https://img.shields.io/badge/Architecture-Feature%20First-4CAF50?style=for-the-badge" alt="Architecture"/>
</p>

| Category | Package | Purpose |
|----------|---------|---------|
| 🧠 **State Management** | `flutter_bloc` | Scalable state management using Bloc and Cubit patterns |
| 🌐 **Networking** | `dio` | Powerful HTTP client with interceptors, retry, and logging |
| 🔌 **API Layer** | `retrofit` | Type-safe API client generation with compile-time validation |
| 📦 **Serialization** | `json_annotation` + `json_serializable` | Automated JSON-to-model code generation |
| ⚙️ **Code Generation** | `build_runner` | Orchestrates code generation for models and API services |
| 💉 **DI** | `get_it` | Lightweight service locator for dependency injection |
| 🔒 **Secure Storage** | `flutter_secure_storage` | Encrypted storage for JWT tokens and sensitive data |
| 🌍 **Localization** | `flutter_localizations` + `intl` | Full Arabic and English localization with RTL support |
| 🔄 **Equality** | `equatable` | Value-based equality for state objects |

<br/>

---

## Architecture

The application follows a **feature-first architecture** with a shared foundation layer, ensuring long-term maintainability and scalability as the platform grows.

```
lib/
│
├── core/                          # Shared foundation layer
│   ├── di/                        # Dependency injection (GetIt)
│   ├── networking/                # Dio client, interceptors, base API
│   ├── routing/                   # Navigation and route definitions
│   ├── helpers/                   # Constants, extensions, utilities
│   ├── theming/                   # Theme data, colors, typography
│   └── widgets/                   # Reusable shared widgets
│
└── features/                      # Feature modules
    ├── auth/                      # Authentication module
    │   ├── data/
    │   │   ├── models/            # Request/response DTOs
    │   │   ├── repo/              # Repository implementation
    │   │   └── datasources/       # Remote data sources
    │   ├── logic/
    │   │   └── cubit/             # Auth Cubit states & events
    │   └── ui/
    │       ├── screens/           # Login, Register screens
    │       └── widgets/           # Auth-specific widgets
    │
    ├── home/                      # Home / Course browsing
    ├── courses/                   # Course details, search, filter
    ├── learning/                  # My Courses, lesson player
    ├── cart/                      # Cart & checkout
    ├── certificates/              # Certificate generation & viewing
    └── instructor/                # Instructor dashboard & course management
```

### Architecture Principles

| Principle | Application |
|-----------|-------------|
| 🎯 **Single Responsibility** | Every module and class has one clearly defined purpose |
| 🔗 **Separation of Concerns** | Data, logic, and presentation layers are fully decoupled |
| 🧪 **Testability** | Repository pattern and DI enable isolated unit testing |
| 📈 **Scalability** | Feature modules can be added, modified, or removed independently |
| 🔄 **Unidirectional Data Flow** | UI → Event → Cubit → State → UI |

<br/>

---

## Project Structure

<pre>
lib/
├── main.dart
├── core/
│   ├── di/
│   │   └── injection_container.dart
│   ├── networking/
│   │   ├── api_client.dart
│   │   ├── api_interceptors.dart
│   │   └── api_service.dart
│   ├── routing/
│   │   └── app_router.dart
│   ├── helpers/
│   │   ├── constants.dart
│   │   └── extensions.dart
│   ├── theming/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   └── widgets/
│       └── widgets.dart
│
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repo/
│   │   ├── logic/
│   │   │   └── cubit/
│   │   └── ui/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   └── ... (additional feature modules)
│
assets/
├── images/
└── fonts/
</pre>

<br/>

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ^3.12.2
- [Dart SDK](https://dart.dev/get-dart) ^3.12.2

### Installation

```bash
# Clone the repository
git clone https://github.com/Coachspacs/Coachspacs_App.git

# Navigate to the project
cd coach_space

# Install dependencies
flutter pub get

# Run code generation (required after adding/modifying models or API services)
dart run build_runner build --delete-conflicting-outputs

# Launch the app
flutter run
```

### Code Generation

This project relies on code generation for JSON serialization and Retrofit API services.

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode — automatically regenerates on changes
dart run build_runner watch --delete-conflicting-outputs
```

<br/>

---

## Localization

The app supports **Arabic** and **English** with automatic RTL/LTR layout switching. Translation files are managed through Flutter's built-in localization system.

```
lib/
└── l10n/
    ├── app_ar.arb
    └── app_en.arb
```

---

## Development Roadmap

| Phase | Sprint | Focus | Status |
|-------|--------|-------|--------|
| **Sprint 0** | Prep | Architecture setup, dependencies, CI/CD | ✅ Complete |
| **Sprint 1** | 1 | Authentication, Home, Categories | ⏳ In Progress |
| **Sprint 2** | 2 | Course browsing, filtering, course creation | 🔜 Planned |
| **Sprint 3** | 3 | My Courses dashboard, lesson player, progress tracking | 🔜 Planned |
| **Sprint 4** | 4 | Cart, checkout, certificates, instructor dashboard | 🔜 Planned |

---

## Contributing

This project is developed as part of a structured training program under the **Coach Space** initiative. All contributions follow the agreed-upon sprint plan and coding standards.

---

<p align="center">
  <strong>Coach Space</strong> — Empowering knowledge, one course at a time.
  <br />
  <sub>Built with ❤️ by the Coach Space Team</sub>
</p>
