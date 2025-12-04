import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:localingo/localingo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sintir/Core/Managers/Cubits/LocalizationCubit/LocaleCubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/Themes/theme_cubit.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/App_router.dart';
import 'package:sintir/Core/widgets/PrivacyWrapper.dart';
import 'package:sintir/Features/Favorites/Domain/Repos/FavoritesRepo.dart';
import 'package:sintir/Features/Favorites/presentation/views/Manager/favourites_cubit/favourites_cubit.dart';
import 'package:sintir/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(appDocDir.path),
  );
  HydratedBloc.storage = storage;
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    shared_preferences_Services.init()
  ]);
  setup_Getit();
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
    final navigatorKey = App_router.navigatorKey;
    Localingo.setNavigatorKey(navigatorKey);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavouritesCubit(
            favoritesRepo: getIt<FavoritesRepo>(),
          ),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, localeState) {
              return MaterialApp.router(
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: LocaleCubit.supportedLocales,
                locale: localeState,
                debugShowCheckedModeBanner: false,
                routerConfig: App_router.router,
              );
            },
          );
        },
      ),
    );
  }
}
