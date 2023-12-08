import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:team_hack/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_hack/bloc/bloc_navigationbar/navigationbar_bloc.dart';
import 'db/supabase_db.dart';
import 'screens/navigationbar/navigation_bar_screen.dart';
import 'screens/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_hack/bloc/theme_bloc/them_.state.dart';
import 'package:team_hack/bloc/theme_bloc/them_bloc.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupaBaseDB().initializeSupa();
  prefs = await SharedPreferences.getInstance();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        if (state is GetThemeState) {
          return MaterialApp(
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              home: SupaBaseDB().isTokenExpired()
                  ? const StartScreen()
                  : const NavigationBarScreen());
        } else {
          return Container();
        }
      }),
    );
  }
}
