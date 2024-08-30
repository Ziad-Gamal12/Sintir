import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/firebase_options.dart';
import 'package:sintir/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Sintir());
}

class Sintir extends StatelessWidget {
  const Sintir({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale("ar"),
      theme: ThemeData(fontFamily: "Cairo", primaryColor: KMainColor),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Text("سنتر"),
      ),
    );
  }
}
