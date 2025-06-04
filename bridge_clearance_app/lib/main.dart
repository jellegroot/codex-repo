import 'package:flutter/material.dart';

void main() => runApp(const BridgeClearanceApp());

class BridgeClearanceApp extends StatelessWidget {
  const BridgeClearanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doorvaarhoogte',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _bridgeHeightController = TextEditingController();
  final TextEditingController _waterLevelController = TextEditingController();
  final TextEditingController _boatHeightController = TextEditingController();

  String _result = '';

  @override
  void dispose() {
    _bridgeHeightController.dispose();
    _waterLevelController.dispose();
    _boatHeightController.dispose();
    super.dispose();
  }

  void _calculate() {
    final bridgeHeight = double.tryParse(_bridgeHeightController.text) ?? 0.0;
    final waterLevel = double.tryParse(_waterLevelController.text) ?? 0.0;
    final boatHeight = double.tryParse(_boatHeightController.text) ?? 0.0;

    final clearance = bridgeHeight - waterLevel - boatHeight;
    if (clearance >= 0) {
      _result = 'Je kunt doorvaren met ' +
          clearance.toStringAsFixed(2) +
          ' meter ruimte.';
    } else {
      _result = 'Je kunt niet doorvaren. Je komt ' +
          clearance.abs().toStringAsFixed(2) +
          ' meter te kort.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doorvaarhoogte')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _bridgeHeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Brughoogte (m)',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _waterLevelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Waterstand t.o.v. kanaalpeil (m)',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _boatHeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hoogte van de boot (m)',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Bereken'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
