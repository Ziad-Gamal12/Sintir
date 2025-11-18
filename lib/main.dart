import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sintir/Core/services/BlocObserver.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/App_router.dart';
import 'package:sintir/Core/widgets/PrivacyWrapper.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/firebase_options.dart';
import 'package:sintir/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    shared_preferences_Services.init()
  ]);
  setup_Getit();
  Bloc.observer = Custom_Blocobserver();
  runApp(
    const Portal(
      child: PrivacyWrapper(
        child: Sintir(),
      ),
    ),
  );
}

class Sintir extends StatelessWidget {
  const Sintir({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: "Cairo",
          primaryColor: KMainColor,
          sliderTheme: SliderThemeData(
            activeTrackColor: KMainColor,
            inactiveTrackColor: KMainColor.withOpacity(0.3), // background line
            thumbColor: KMainColor,
            overlayColor: KMainColor.withOpacity(0.2),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      routerConfig: App_router.router,
    );
  }
}
