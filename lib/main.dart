import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/tab.dart';


final theme= ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromRGBO(255, 131, 57, 0),
  ),

      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )

      ),

      fontFamily: 'Lato',
);
void main()
{

  runApp(const ProviderScope(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
        home:TabsScreen(),
    );
  }
}
