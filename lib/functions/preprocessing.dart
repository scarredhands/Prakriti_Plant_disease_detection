import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../models/tflite_model.dart';

// Preprocess image for TFLite model
Future<List<List<List<List<double>>>>> preprocessImage(String imagePath) async {
  // Load image as bytes
  final File imageFile = File(imagePath);
  final List<int> imageBytes = await imageFile.readAsBytes();

  // Decode image using the new 'image' package
  img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

  if (image == null) {
    throw Exception("Failed to decode the image.");
  }

  // Resize image to 224x224 (or your model’s input size)
  img.Image resizedImage = img.copyResize(
    image,
    width: 224,
    height: 224,
    interpolation: img.Interpolation.linear,
  );

  // Normalize pixel values to [0, 1]
  List<List<List<double>>> imageMatrix = [];
  for (int y = 0; y < resizedImage.height; y++) {
    List<List<double>> row = [];
    for (int x = 0; x < resizedImage.width; x++) {
      final pixel = resizedImage.getPixel(x, y);
      row.add([
        img.getRed(pixel) / 255.0, // Red channel
        img.getGreen(pixel) / 255.0, // Green channel
        img.getBlue(pixel) / 255.0, // Blue channel
      ]);
    }
    imageMatrix.add(row);
  }

  // Return a 4D tensor input with shape [1, 224, 224, 3]
  return [imageMatrix];
}

// Future<String> predictDisease(String imagePath) async {
//   if (interpreter == null) {
//     throw Exception('Model not loaded. Please load the model first.');
//   }
//
//   // Preprocess image
//   List<List<List<List<double>>>> input = await preprocessImage(imagePath);
//
//   // Define output tensor (change based on the number of classes)
//   var output = List.filled(1 * 5, 0).reshape([1, 5]);
//
//   // Run inference
//   interpreter.run(input, output);
//
//   // Load labels
//   List<String> labels = await loadLabels();
//
//   // Get predicted class index
//   int predictedIndex = output[0]
//       .indexWhere((val) => val == output[0].reduce((a, b) => a > b ? a : b));
//
//   // Return predicted label
//   return labels[predictedIndex];
// }

Future<Map<String, dynamic>> predictDisease(String imagePath) async {
  if (interpreter == null) {
    throw Exception('Model not loaded. Please load the model first.');
  }
  // Preprocess image
  List<List<List<List<double>>>> input = await preprocessImage(imagePath);

  // Define output tensor (change based on the number of classes)
  List<List<double>> output = List.generate(1, (i) => List.filled(15, 0.0));

  // Run inference
  interpreter.run(input, output);

  // Load labels
  List<String> labels = await loadLabels();

  // Get predicted class index
  int predictedIndex = output[0].indexWhere(
    (val) => val == output[0].reduce((a, b) => a > b ? a : b),
  );

  double confidence = output[0][predictedIndex];
  String predictedLabel = labels[predictedIndex];

  return {
    "label": predictedLabel,
    "confidence": confidence.toStringAsFixed(2),
  };
}
