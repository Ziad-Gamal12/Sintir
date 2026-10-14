<div align="center"><img src="assets/Icons/SVG_Icons/AppLogo.svg" alt="Sintir Admin Panel Logo" width="96" />Sintir Admin PanelA responsive Flutter Web back-office platform for managing users, courses, support operations, payouts, and real-time analytics across the Sintir educational ecosystem.Live Demo · Companion Mobile App Repo</div>📖 OverviewSintir Admin Panel (sintir_dashboard) is the administrative control center for the Sintir digital learning platform. Built with Flutter Web, it empowers operations teams, course managers, and support staff to oversee platform activity from a single responsive interface:Executive Analytics & KPIs: Monitor platform revenue, user demographics, enrollment trends, and course performance through interactive charts (fl_chart).Granular Role-Based Access Control (RBAC): Enforce database-driven permissions across 5 distinct operational roles (Admin, CoursesManager, UsersManager, Support, and Viewer) with active-status verification.Course & Instructor Governance: Review, filter, publish, edit, or remove courses, inspect section content, moderate student reports, and audit course transactions.User & Wallet Operations: Search and filter users with server-side pagination, inspect individual wallets and transaction histories, and manage account statuses.Real-Time Support Desk: Triage support tickets, track resolution analytics, and communicate directly with students and teachers in a dedicated support chat interface.Serverless Media & Payout Backend: Houses the Supabase Edge Functions powering Mux direct video uploads/signed playback tokens and Paymob instructor withdrawals.📸 ScreenshotsLight ModeDark Mode<img src="docs/screenshots/dashboard-light.png" alt="Dashboard Light Mode" width="420" /><img src="docs/screenshots/dashboard-dark.png" alt="Dashboard Dark Mode" width="420" /><img src="docs/screenshots/users-light.png" alt="Users Management Light Mode" width="420" /><img src="docs/screenshots/users-dark.png" alt="Users Management Dark Mode" width="420" /><img src="docs/screenshots/course-details-light.png" alt="Course Details Light Mode" width="420" /><img src="docs/screenshots/support-dark.png" alt="Support Chat Dark Mode" width="420" />✨ Features by ModuleModuleKey CapabilitiesAuthentication (Auth)Email/password sign-in, staff registration, password reset via Firebase Auth, and session-aware route redirection.Analytics Overview (Dashboard)Responsive KPI summary cards, revenue trajectories, gender distribution breakdowns, and course analytics charts.Courses Management (CoursesManagment)Searchable, filterable, responsive course directory with status badges and quick moderation actions.Course Deep-Dive (CourseDetails)Full inspection of course sections, lecture items, student reports, reviews/feedback, subscribers, coupons, and financial transactions.Creator Profile (ContentCreatorProfile)Instructor profile overview, teaching portfolio, and associated course metrics.Users Management (UsersManagement)Paginated Firestore directory (10 records per page, ordered by joinedDate) with multi-criteria filtering by role, account status, and gender.User Profile & Wallet (UserDetails)Detailed user inspection, profile editing, role/status updates, activity logs, wallet balance monitoring, and transaction history.Support Center (Support)Ticket queue management, ticket volume analytics, status updates, and real-time support chat messaging.Serverless Pipeline (supabase/functions)Deno/TypeScript Edge Functions orchestrating Mux video uploads, webhook verification, signed playback tokens, and Paymob teacher payouts.🔐 Role-Based Access Control (RBAC) & RoutingUser roles and account statuses are stored in the Firestore Users collection and evaluated locally via lib/Core/Permissions/Permissions Mapping.dart. Every permission check requires the user's account status to be Active.Role MatrixRoleGranted PermissionsAdminFull superuser access across all modules and actions (bypasses individual permission checks).CoursesManagerviewCourses, publishCourse, editCourse, deleteCourseUsersManagerviewUsers, editUser, deleteUserSupportviewTickets, replyTickets, changeTicketStatus, banUserViewer (Default fallback)viewUsers, viewTickets, viewCourses, viewAnalyticsComplete Declared Permission Set (15 granular flags):
viewUsers, createUser, editUser, deleteUser, banUser, viewCourses, createCourse, editCourse, deleteCourse, publishCourse, viewTickets, replyTickets, changeTicketStatus, viewAnalytics, exportData.Declarative Routing (GoRouter)Configured in lib/Core/Utils/App_router.dart, the router enforces active session checks before rendering protected views, while individual feature views enforce module-level permissions (rendering AccessDeniedWidget or hiding restricted actions):Route PathScreenAccess & State Handling/SplashViewPublic entry; routes based on cached session state/SignInViewSignInViewPublic; redirects authenticated active sessions to /dashboard/signUpViewSignUpViewPublic staff/user registration/teacherResetPasswordViewCustomResetPasswordViewPublic password recovery flow/dashboardResponsiveDashboardViewRequires active authenticated session (UID + Active status)/courses-managmentResponsiveCoursesManagmentViewSession guard + UI-level Permission.viewCourses check/responsive_course_details_viewResponsiveCourseDeatilsViewSession guard; receives course object via state.extra/ContentCreatorProfileContentCreatorProfileSession guard; receives creator entity via state.extra/ResponsiveUsersManagementViewResponsiveUsersManagementViewSession guard + UI-level Permission.viewUsers check/responsive-user-detailsResponsiveUserDetailsViewSession guard; receives target UID via state.extra/ResponsiveTicketsManagementViewResponsiveTicketsManagementViewSession guard + UI-level Permission.viewTickets check/SupportChatViewResponsiveSupportChatViewSession guard; receives ticket entity via state.extra/unauthorizedUnauthorizedViewDisplayed when session or access requirements fail🛠 Tech StackLayerPackages & ToolsFramework & SDKFlutter (Web, Windows, macOS, Android, iOS), Dart ^3.10.4State Managementflutter_bloc ^9.1.1, bloc ^9.1.0, hydrated_bloc ^11.0.0, provider ^6.1.5+1Dependency Injectionget_it ^9.2.0Routinggo_router ^17.0.1Backend & Cloudfirebase_core ^4.3.0, firebase_auth ^6.1.3, cloud_firestore ^6.1.1, firebase_storage ^13.0.5, supabase_flutter ^2.12.0Networkingdio ^5.9.0Data Visualization & Tablesfl_chart ^1.1.1, data_table_2 ^3.0.0UI, Icons & Animationsflutter_animate ^4.5.2, skeletonizer ^2.1.2, loading_animation_widget ^1.3.0, cached_network_image ^3.4.1, lucide_icons_flutter ^3.1.15, font_awesome_flutter ^11.0.0, svg_flutter ^0.0.1Security & Local Storageflutter_secure_storage ^11.0.0, hive_flutter ^1.1.0, secure_content ^2.0.0, device_info_plus ^13.2.0Localizationflutter_localizations, intl (Arabic & English ARB files)Functional & Utilitiesdartz ^0.10.1, equatable, uuid, image_picker ^1.2.1, path_provider ^2.1.5🏗 ArchitectureThe project follows a feature-first MVVM / Clean Architecture pattern powered by BLoC/Cubit and Repository abstractions. Shared services and repositories are registered in lib/Core/Services/get_it_Service.dart after main.dart initializes Firebase, Supabase, Hive, and HydratedBloc storage.flowchart LR
    V[Responsive View / Widgets] --> C[Feature Cubit]
    C --> R[Repository Abstraction]
    R --> RI[Repository Implementation]
    RI --> S[Shared Service<br/>DataBaseService / Dio]
    S --> F[(Cloud Firestore &<br/>Firebase Auth)]
    S --> SB[(Supabase<br/>Edge Functions)]
Example Workflow: Paginated Users ManagementPermission Check: UsersManagementViewBody reads the locally cached user profile and verifies Permission.viewUsers.DI & State Provision: If authorized, it provides UsersManagementCubit injected with getIt<UsersRepo>().Query Execution: The Cubit invokes UsersRepo.getUsers() with the active search query, role/status/gender filters, and pagination cursor.Firestore Mapping: UsersRepoImpl constructs a query on the Users collection (ordered by joinedDate, page size 10) and calls DataBaseService.getData() (FirebaseFirestoreservice), mapping documents into UserEntity objects.Folder Structurelib/
├── Core/
│   ├── Entities/          # Shared domain entities
│   ├── Errors/            # Custom Failure classes and error handlers
│   ├── Helper/            # Responsive layout helpers and UI utilities
│   ├── Managers/          # App-wide Cubits (e.g., ThemeCubit)
│   ├── Models/            # Shared data models
│   ├── Permissions/       # RBAC roles and permission mapping logic
│   ├── Services/          # Firebase, Supabase, Dio, and GetIt registration
│   ├── Themes/            # Light and Dark theme configurations (app_theme.dart)
│   ├── Utils/             # GoRouter configuration (App_router.dart) and constants
│   ├── repos/             # Shared repository contracts and implementations
│   └── widgets/           # Reusable dashboard tables, cards, and access-denied views
├── Features/
│   ├── Auth/
│   ├── ContentCreatorProfile/
│   ├── CourseDetails/
│   ├── CoursesManagment/
│   ├── Dashboard/
│   ├── Splash/
│   ├── Support/
│   ├── UserDetails/
│   └── UsersManagement/
├── generated/             # Auto-generated localization classes
├── l10n/                  # intl_ar.arb and intl_en.arb translation sources
├── constant.dart          # Brand colors, version, and public Supabase config
├── firebase_options.dart  # Platform-specific Firebase configuration
└── main.dart              # Application bootstrap
supabase/
└── functions/             # Serverless Edge Functions (Mux video & Paymob payouts)
☁️ Backend & Serverless InfrastructureCloud Firestore SchemaTop-Level Collections: Users, Teachers, Students, Transactions, Courses, Tickets, MuxVideoIndex, MuxWebhookEventsNested Collections: Sections, Items, Reports, Feedbacks, Coupons, Subscribers, JoinedBy, Results, MyResults, MyMistakes, Favorites, VideoNotes, and MessagesSupabase Edge Functions (supabase/functions)Edge FunctionPurposecreate-video-uploadVerifies teacher identity, creates a Mux direct-upload session, and records video metadata in Firestoreresume-video-uploadChecks whether an interrupted Mux upload session remains resumablecancel-video-uploadCancels a pending upload or Mux asset and updates the corresponding Firestore recordget-video-playback-tokenValidates course access and issues a signed JWT playback token for Mux video streamingmux-webhookVerifies Mux webhook signatures and updates Firestore video processing states in real timeteacher-withdrawalReserves and executes instructor wallet payouts via Paymob with reconciliation supportsintir-analyticsAggregates platform analytics queried by the dashboard via DioFor detailed documentation on the video streaming and webhook architecture, see MUX_VIDEO.md.🎨 Theming & LocalizationTypography: Uses the Cairo typeface (Regular, Medium, SemiBold, Bold) for crisp Arabic and English legibility.Brand Palette: Primary Royal Blue (#4169E2) and Secondary Vibrant Orange (#FF8C1A), with custom Light and Dark surface tokens defined in lib/Core/Themes/app_theme.dart.Persistent Theme State: ThemeCubit defaults to Dark Mode and persists user preference across browser sessions using HydratedBloc.Bilingual Support: Includes Arabic (lib/l10n/intl_ar.arb) and English (lib/l10n/intl_en.arb) localization files with generated delegates under lib/generated/.🚀 Getting StartedPrerequisitesFlutter SDK with Dart ^3.10.4A Firebase project (Authentication, Cloud Firestore, Storage, Hosting)A Supabase project + Supabase CLI (for Edge Functions)Firebase CLI or Vercel CLI (for web deployment)1. Clone & Run Locallygit clone https://github.com/Ziad-Gamal12/Sintir_DashBoard.git
cd Sintir_DashBoard
flutter pub get
flutter run -d chrome
2. Configure Client & Serverless EnvironmentFirebase: Generate lib/firebase_options.dart for your Firebase project using flutterfire configure.Supabase Client: Set supaBaseUrl and supaAnonKey in lib/constant.dart.Edge Function Secrets: Copy supabase/functions/.env.example to supabase/functions/.env and populate the required server-side credentials:FB_PROJECT_ID
FB_CLIENT_EMAIL
FB_PRIVATE_KEY
PAYMOB_PAYOUT_CLIENT_ID
PAYMOB_PAYOUT_CLIENT_SECRET
PAYMOB_PAYOUT_USERNAME
PAYMOB_PAYOUT_PASSWORD
PAYMOB_WEBHOOK_HMAC_SECRET
MUX_TOKEN_ID
MUX_TOKEN_SECRET
MUX_WEBHOOK_SECRET
MUX_SIGNING_KEY_ID
MUX_SIGNING_KEY_PRIVATE_BASE64
Security Note: Never commit supabase/functions/.env or private keys to Git. Only the public supaAnonKey belongs in the Flutter client.Serve or Deploy Edge Functions:# Serve locally
supabase functions serve --env-file supabase/functions/.env

# Deploy to Supabase
supabase functions deploy <function-name> --no-verify-jwt
3. Build & Deploy Web Dashboard# Build production web bundle
flutter build web

# Option A: Deploy to Firebase Hosting (SPA rewrite configured in firebase.json)
firebase deploy --only hosting

# Option B: Deploy to Vercel (SPA rewrite configured in vercel.json)
vercel --prod
👤 AuthorZiad Gamal — Flutter DeveloperLinkedIn: linkedin.com/in/ziad-gamal-54b052375GitHub: @Ziad-Gamal12Email: ziadgamal.work@gmail.com
