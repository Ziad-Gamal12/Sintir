 Sintir – Educational Mobile Platform (Flutter)

Sintir is a scalable and flexible educational platform built with Flutter, designed to support both students and teachers.
The app provides a complete learning environment that includes courses, videos, exams, files, payments, feedback, reports, and analytics, along with a full teacher workspace for managing online classes.

 Demo

APK (temporary preview until publishing):
Download APK (https://drive.google.com/file/d/1dAe2gH98RGZ38Em0jMGJV67vPL8RVt6r/view?usp=sharing)

(Replace the link above when ready)

 Main Features
 Student Features

Email verification & secure sign-in

Explore courses by category, price, rating, recency, and educational level

View course details with subscription options

Apply coupons for discounted prices

Pay using Paymob (wallets + credit cards) via WebView

Watch video lectures

Read PDF files

View quizzes & exam details

Submit answers with result summary (correct/incorrect count, explanation images, mistakes tracking)

Attempts limit logic (fixed/unlimited)

Locked result visibility when hidden by the teacher

Add notes, ask questions, send reports

Add feedback & view others' feedback

Wishlist for courses

Profile management (photo update, personal info, language switch, dark/light mode)

Prevent screenshots & screen recording

Smart logic for one-device login enforcement

 Teacher Features

Dedicated teacher onboarding

Teacher workspace with:

3D credit card view

Total earnings, balance, and transaction history

Withdraw & refund logic (processed by admin activation)

Full course creation & management

Add and edit:

Video lectures

PDF files

Exams & questions

Attempts count

Show/hide results

Exam duration

Course coupons system (create, activate/deactivate)

Students list (per course) with:

Search

Student details

Subscription history

Performance analytics chart (avg/highest/lowest)

All student exam results

Video consequences view:

Notes from students

Watching analytics

Exam consequences:

Attendance counts and percentages

Success/failure distribution

Highest & lowest scores

 Tech Stack

Flutter & Dart

Bloc / Cubit (State Management)

GoRouter (Navigation)

Firebase Authentication

Firebase Firestore

Firebase Storage

Paymob API

Chewie + Video Player

PDFX for PDF reading

GetIt (Dependency Injection)

 Tech Highlights

Clean architecture with feature-based modularization

Separation into: Core / Features / Data / Domain / Presentation

Pagination for heavy course/exam data

UI rebuilding optimization using advanced Bloc patterns

Preventing screenshots & screen recording

Scalable data storage and refactoring

One-device login restriction logic

Multi-language support (AR / EN / FR)

Smooth performance on low-end devices

 Folder Structure 
lib/
 ├── core/
 │   ├── errors/
 │   ├── constants/
 │   ├── theme/
 │   ├── utils/
 │   ├── widgets/
 │   └── services/
 │
 ├── features/
 │   ├── auth/
 │   │   ├── data/
 │   │   ├── domain/
 │   │   └── presentation/
 │   │
 │   ├── courses/
 │   │   ├── data/
 │   │   ├── domain/
 │   │   └── presentation/
 │   │
 │   ├── exams/
 │   ├── videos/
 │   ├── files/
 │   ├── teacher/
 │   ├── student/
 │   └── profile/
 │
 ├── router/
 ├── injections.dart
 └── main.dart

 Installation & Setup
1. Clone the repository
git clone https://github.com/Ziad-Gamal12/Sintir.git

2. Install dependencies
flutter pub get

3. Add your Firebase configuration

Place your:

google-services.json (Android)

GoogleService-Info.plist (iOS)

4. Run the app
flutter run

 Challenges & Solutions

Managing huge, multi-role data structure (student + teacher)

Implementing scalable architecture for 70+ screens

Designing UI/UX from scratch using Figma without pre-existing design

Applying pagination & isolation for performance

Handling heavy views (exams, videos, analytics) efficiently

Implementing result visibility, attempts limit, and dynamic exam logic

Creating a full course management system

Solving one-device login complexity

Implementing safe mode (prevent screenshots/recording)

Repository

GitHub: https://github.com/Ziad-Gamal12/Sintir.git
