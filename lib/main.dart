import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(CalcApp(isDarkMode: isDarkMode));
}

class CalcApp extends StatefulWidget {
  final bool isDarkMode;
  const CalcApp({super.key, required this.isDarkMode});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  Future<void> _toggleTheme(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Калькулятор и конвертер',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
      builder: (context, child) {
        return Builder(
          builder: (context) {
            final theme = Theme.of(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Калькулятор и конвертер'),
                actions: [
                  Switch(
                    value: theme.brightness == Brightness.dark,
                    onChanged: _toggleTheme,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              body: child!,
            );
          },
        );
      },
    );
  }
}