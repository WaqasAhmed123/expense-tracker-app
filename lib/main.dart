import 'package:blocship/cubits/entry_cubit.dart';
import 'package:blocship/cubits/home_cubit.dart';
import 'package:blocship/screens/home_screen.dart';
import 'package:blocship/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'screens/entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.getTotalAmountByEntryType("expense");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<EntryCubit>(create: (context) => EntryCubit()),
        // Add more providers if needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          )),
          scaffoldBackgroundColor: const Color(0xFFeae8e9),
          primaryColor: Colors.grey,
          // primaryColorLight: Colors.grey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        // home: const EntryScreen(),
        // home: const HomeScreen(),
        home: const EntryScreen(),
      ),
    );
  }
}
