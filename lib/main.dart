import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/utils/fire/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  /// enleve le # dans l'url
  setPathUrlStrategy();
  /// pour android
  WidgetsFlutterBinding.ensureInitialized();
  /// init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
