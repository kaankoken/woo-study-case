import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/app_localization_delegate.dart';
import 'package:woo_study_case/core/exports.dart';
import 'package:woo_study_case/core/route/routes.dart';
import 'package:woo_study_case/injector.dart';
import 'package:woo_study_case/presentation/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjector();

  runApp(const ProviderScope(child: WooStudyCase()));
}

class WooStudyCase extends ConsumerStatefulWidget {
  const WooStudyCase({Key? key}) : super(key: key);

  @override
  WooStudyCaseState createState() => WooStudyCaseState();
}

class WooStudyCaseState extends ConsumerState<WooStudyCase> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woo Study Case',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldKey,
      home: const SplashView(),
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', ''),
        Locale('en', ''),
      ],
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
