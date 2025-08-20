# 🎓 Sinitr – Educational Mobile App (Work in Progress)

Sinitr is an **educational platform** built with **Flutter** that connects **teachers** and **students** in one ecosystem.  
It supports learning through video, PDF, quizzes, and AI-powered interactions with plans to extend into a **3D AI Teacher avatar**.  

⚠️ **Note:** The app is still under active development. Features, UI, and performance will continue to evolve before production release.  

---

## ✨ Core Features
- **Splash Screen** – Animated introduction  
- **Role Selection** – Choose between Student or Teacher role  
- **Teacher Onboarding** – Guided flow for educators  
- **Student Onboarding** – Guided flow for learners  
- **Teacher Authentication** – Secure login & registration  
- **Student Authentication** – Secure login & registration  
- **Home Dashboard** – Personalized student/teacher experience  
- **AI Teacher (Beta)** – Interactive voice-based assistant (future upgrade: 3D avatar)  
- **Teacher Profile** – Manage courses & professional info  
- **Student Profile** – Track progress & enrolled courses  
- **Teacher Work Environment** – Full course creation & management tools  
- **Course Management**  
  - Add/edit/delete sections  
  - Upload **videos, PDFs, audio files**  
  - Create **MCQ quizzes & timed tests**  
- **Course Details (Student View)** – Study content, take quizzes, track results  
- **Books Library** – Manage course assets & documents  
- **Favorites** – Save and revisit important lessons  
- **Payment Logic (WIP)** – Handle subscriptions & course purchases  

---

## 🛠️ Tech Stack
- **Flutter & Dart** – Cross-platform development  
- **Bloc / Cubit** – State management  
- **Firebase Auth** – Teacher & Student authentication  
- **Firebase Firestore** – Real-time courses, quizzes & subscriptions  
- **Firebase Storage** – Multimedia course content (PDFs, videos, audio)  
- **GoRouter** – Role-based navigation  
- **Video Player + Chewie** – Cached video playback  
- **PDFX** – In-app PDF viewer  
- **Speech_to_text** – AI Teacher & voice quizzes  
- **StopWatchTimer** – Timed assessments  
- **Lottie Animations** – Smooth onboarding/UI animations  
- **WebView** – Embedded web resources  
- **Payment Integration (In Progress)**  

---

## 📂 Repository Overview
lib/
├── Core/ # Core utilities & constants
├── Features/ # App Features
│ ├── Ai_Teacher/ # AI Teacher feature
│ ├── Books_Library/ # Course library
│ ├── ChoosingUserKind/ # Role selection
│ ├── Course Management/ # Teacher course tools
│ ├── Favorites/ # Favorites management
│ ├── Home/ # Home dashboard
│ ├── Splash/ # Splash & onboarding
│ ├── StudenetAuth/ # Student authentication
│ ├── StudentOnboarding/ # Student onboarding
│ ├── StudentProfile/ # Student profile
│ ├── TeacherAuth/ # Teacher authentication
│ ├── TeaacherOnBoarding/# Teacher onboarding
│ ├── TeacherProfile/ # Teacher profile
│ ├── TeacherWorkEnv/ # Teacher workspace
│ └── tasks/ # Task/assignment UI
└── main.dart # App entry point


---

## 🚧 Development Status
- ✅ Teacher & Student onboarding/auth flows  
- ✅ Course management (sections, videos, PDFs, quizzes)  
- ✅ AI Teacher (Beta) with voice interaction  
- ✅ Favorites & library integration  
- ✅ Payment process logic (in progress)  
- 🔜 3D AI Teacher avatar  
- 🔜 Gamification & badges system  
- 🔜 Performance optimizations & caching  
- 🔜 Production release  

---

## 📥 Getting Started
Clone the repo & run locally:  
```bash
git clone https://github.com/Ziad-Gamal12/Sintir.git
cd Sinitr
flutter pub get
flutter run


👨‍💻 Author
Ziad Gamal

🌐 https://ziadgamal.vercel.app/

📧 ziadgemy123@gmail.com

🔗 https://www.linkedin.com/in/ziad-gamal-54b052375/
