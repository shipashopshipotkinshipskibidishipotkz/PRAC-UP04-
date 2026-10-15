import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/calculator'),
                icon: const Icon(Icons.calculate),
                label: const Text('Калькулятор'),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.go('/converter'),
                icon: const Icon(Icons.currency_exchange),
                label: const Text('Конвертер валют'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}