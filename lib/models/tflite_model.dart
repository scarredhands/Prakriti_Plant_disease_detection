import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

late Interpreter interpreter; // Define interpreter globally

Future<void> loadModel() async {
  try {
    final interpreterOptions = InterpreterOptions();
    interpreter = await Interpreter.fromAsset(
      'assets/model.tflite',
      options: interpreterOptions,
    );
    print("✅ Model loaded successfully!");
  } catch (e) {
    print("❌ Failed to load model: $e");
  }
}

Future<List<String>> loadLabels() async {
  final labelsData = await rootBundle.loadString('assets/labels.txt');
  List<String> labels = labelsData.split('\n').map((l) => l.trim()).toList();
  return labels.where((label) => label.isNotEmpty).toList();
}
