import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/currency.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';

  @override
  void initState() {
    super.initState();
    _loadSavedCurrencies();
  }

  Future<void> _loadSavedCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fromCurrency = prefs.getString('fromCurrency') ?? 'USD';
      _toCurrency = prefs.getString('toCurrency') ?? 'EUR';
    });
  }

  Future<void> _saveCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fromCurrency', _fromCurrency);
    await prefs.setString('toCurrency', _toCurrency);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите сумму';
    if (double.tryParse(value.replaceAll(',', '.')) == null) {
      return 'Это не число';
    }
    if (double.parse(value.replaceAll(',', '.')) <= 0) {
      return 'Сумма должна быть больше нуля';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = _amountController.text.replaceAll(',', '.');
    _saveCurrencies();

    context.go(
      '/converter/result?amount=$amount&from=${Uri.encodeComponent(_fromCurrency)}&to=${Uri.encodeComponent(_toCurrency)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертер валют'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Сумма',
                      border: OutlineInputBorder(),
                    ),
                    validator: _amountValidator,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    decoration: const InputDecoration(
                      labelText: 'Из валюты',
                      border: OutlineInputBorder(),
                    ),
                    items: currencies.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text('${e.key} - ${e.value}'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _fromCurrency = value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _toCurrency,
                    decoration: const InputDecoration(
                      labelText: 'В валюту',
                      border: OutlineInputBorder(),
                    ),
                    items: currencies.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text('${e.key} - ${e.value}'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _toCurrency = value);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('Конвертировать'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}