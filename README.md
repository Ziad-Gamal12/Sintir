📘 Sintir – Educational Mobile Platform (Flutter)

Sintir is a scalable and flexible educational platform built with Flutter, designed for both students and teachers.
It delivers a complete learning environment that includes courses, videos, exams, files, payments, reports, analytics, and a full teacher workspace.

🚀 Demo

APK (Temporary Preview Until Publishing):
👉 Download (https://drive.google.com/file/d/1dAe2gH98RGZ38Em0jMGJV67vPL8RVt6r/view?usp=sharing)

🧩 Main Features
👨‍🎓 Student Features

Email verification & secure authentication

Explore courses by category, price, rating, recency, and educational level

Course subscription with applied coupons

Payments via Paymob (wallets + credit cards) through WebView

Video lecture player

PDF viewer

Quiz & exam viewer

Submit answers with:

Correct/incorrect summary

Explanation images

Mistakes tracking

Attempts limit (fixed or unlimited)

Hidden results (if teacher disables visibility)

Notes, questions, reports

Course feedback system

Add to wishlist

Full profile management (photo, info, theme, language)

Screenshot & screen-recording protection

One-device login restriction logic

👨‍🏫 Teacher Features

Dedicated teacher onboarding

Teacher dashboard with:

3D credit card view

Total earnings, balance & transaction history

Withdraw & refund logic (admin-activated)

Full course management:

Videos

PDFs

Exams & questions

Attempts count

Result visibility toggle

Exam timer

Coupon system (create/activate/deactivate)

Students list (per course):

Search

Student profile

Subscription history

Performance analytics chart

All exam results

Video analytics:

Notes from students

Viewing statistics

Exam analytics:

Attendance percentage

Success/failure rate

Highest and lowest scores

🛠 Tech Stack

Flutter + Dart

Bloc / Cubit (State Management)

GoRouter (Navigation)

Firebase Authentication

Firebase Firestore

Firebase Storage

Paymob API

Chewie + Video Player

PDFX

GetIt (Dependency Injection)

⚙️ Technical Highlights

Clean Architecture with feature-based modules

Layered structure (Core / Data / Domain / Presentation)

Efficient pagination for large datasets

Optimized Bloc rebuild patterns

Screenshot/screen-recording prevention

Strong data refactoring & scalability

One-device login restriction

Multi-language support (AR/EN/FR)

High performance on low-end devices

📁 Folder Structure
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

🧰 Installation & Setup
1. Clone the Repository
git clone https://github.com/Ziad-Gamal12/Sintir.git

2. Install Dependencies
flutter pub get

3. Add Firebase Files

google-services.json → Android

GoogleService-Info.plist → iOS

4. Run the App
flutter run

🧗 Challenges & Solutions

Managing a large, multi-role system (Student + Teacher)

Architecting 70+ screens with long-term scalability

Designing UI/UX manually in Figma from scratch

Implementing effective pagination & performance isolation

Optimizing heavy views (videos, exams, analytics)

Building dynamic exam logic with attempts & hidden results

Designing full course management for teachers

Implementing one-device login security

Enabling screenshot & screen-recording protection

🔗 Repository

GitHub: https://github.com/Ziad-Gamal12/Sintir.git

⭐ Your README is now:

Beautifully structured

Clean and readable

Professional

Easy for HR and developers

ATS-friendly

GitHub-ready
