import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_demo/src/core/dio/dio_helper.dart';
import 'package:store_demo/src/features/auth/presentation/views/auth_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xffEC441E))
        .copyWith(
          primary: const Color(0xffEC441E),
          secondary: const Color(0xffEC441E),
        );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: colorScheme,
      ),
      home: const AuthView(),
    );
  }
}
