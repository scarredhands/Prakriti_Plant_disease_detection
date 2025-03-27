import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Interpreter interpreter;
  bool isModelLoaded = false;
  String? predictedLabel;
  String? confidence;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load the TFLite model
  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/model.tflite');
      setState(() {
        isModelLoaded = true;
      });
      print('✅ Model loaded successfully');
    } catch (e) {
      print('❌ Error loading model: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      Map<String, dynamic> result = await predictDisease(image.path);
      setState(() {
        predictedLabel = result['label'];
        confidence = result['confidence'];
      });
    }
  }

  // Preprocess the image for the model
  Future<List<List<List<List<double>>>>> preprocessImage(
      String imagePath) async {
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

    // Resize to model input size (256x256)
    img.Image resizedImage = img.copyResize(image!, width: 256, height: 256);

    // Normalize pixel values (0 to 1)
    List<List<List<List<double>>>> input = List.generate(
      1,
      (i) => List.generate(
        256,
        (y) => List.generate(
          256,
          (x) {
            var pixel = resizedImage.getPixel(x, y);
            return [
              (img.getRed(pixel).toDouble() / 255.0), // Red channel
              (img.getGreen(pixel).toDouble() / 255.0), // Green channel
              (img.getBlue(pixel).toDouble() / 255.0), // Blue channel
            ];
          },
        ),
      ),
    );

    return input;
  }

  // Load labels from assets
  Future<List<String>> loadLabels() async {
    String labelsData =
        await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
    return labelsData.split('\n').where((label) => label.isNotEmpty).toList();
  }

  // Predict disease from image
  // Future<String> predictDisease(String imagePath) async {
  //   if (!isModelLoaded) {
  //     await loadModel();
  //   }
  //
  //   List<List<List<List<double>>>> input = await preprocessImage(imagePath);
  //
  //   // Define output shape based on number of classes (e.g., 5 classes)
  //   List<List<double>> output = List.generate(1, (i) => List.filled(15, 0.0));
  //
  //   // Run inference
  //   interpreter.run(input, output);
  //
  //   // Load labels
  //   List<String> labels = await loadLabels();
  //
  //   // Get predicted class index
  //   int predictedIndex = output[0].indexWhere(
  //     (val) => val == output[0].reduce((a, b) => a > b ? a : b),
  //   );
  //
  //   return labels[predictedIndex];
  // }

  // Predict disease from image
  Future<Map<String, dynamic>> predictDisease(String imagePath) async {
    if (!isModelLoaded) {
      await loadModel();
    }

    // Preprocess image
    List<List<List<List<double>>>> input = await preprocessImage(imagePath);

    // Define output shape based on number of classes (e.g., 15 classes)
    List<List<double>> output = List.generate(1, (i) => List.filled(15, 0.0));

    // Run inference
    interpreter.run(input, output);

    // Load labels
    List<String> labels = await loadLabels();

    // Get predicted class index
    int predictedIndex = output[0].indexWhere(
      (val) => val == output[0].reduce((a, b) => a > b ? a : b),
    );

    // Get confidence of the predicted class
    double confidence = output[0][predictedIndex] * 100;

    // Return label and confidence as a map
    return {
      'label': labels[predictedIndex],
      'confidence': confidence.toStringAsFixed(2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Disease Detector'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            predictedLabel != null
                ? Column(
                    children: [
                      Text(
                        'Prediction: $predictedLabel',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Confidence: $confidence%',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  )
                : const Text(
                    'Select an image to predict!',
                    style: TextStyle(fontSize: 18),
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => pickImage(ImageSource.gallery),
              icon: const Icon(Icons.image),
              label: const Text('Pick from Gallery'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Image'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
