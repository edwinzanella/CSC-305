import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 106, 95, 125)),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final evaluator = const ExpressionEvaluator();
          final expression = Expression.parse(_expression);
          final result = evaluator.eval(expression, {});
          _result = ' = $result';
        } catch (e) {
          _result = ' Error';
        }
      } else if (value == '^2') {
        try {
          final evaluator = const ExpressionEvaluator();
          final expression = Expression.parse(_expression);
          final result = evaluator.eval(expression, {});
          _expression = '($result)^2';
          final squaredResult = evaluator.eval(Expression.parse('($result) * ($result)'), {});
          _result = ' = $squaredResult';
        } catch (e) {
          _result = ' Error';
        }
      } else if (value == '%') {
        _expression += '%';
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(value),
        child: Text(value, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Name\'s Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                _expression + _result,
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C'),
                    _buildButton('^2'),
                    _buildButton('%'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}