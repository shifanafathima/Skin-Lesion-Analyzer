import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionService {
  static Interpreter? _interpreter;
  static Map<int, String> classIndices = {};

  // -----------------------------
  // LOAD MODEL + CLASS INDICES
  // -----------------------------
  static Future<void> init() async {
    if (_interpreter != null) return;

    // Load TFLite model
    _interpreter = await Interpreter.fromAsset('assets/models/model_final.tflite');

    // Load class index mapping
    final jsonStr = await rootBundle.loadString('assets/models/class_indices.json');
    final Map<String, dynamic> data = json.decode(jsonStr);
    classIndices = data.map((k, v) => MapEntry(int.parse(k), v.toString()));

    print("MODEL + CLASS INDICES LOADED");
  }

  // -----------------------------
  // PREDICTION FUNCTION
  // -----------------------------
  static Future<String> predict(img.Image image, {int topN = 3, double temperature = 1.5}) async {
    await init();

    // Resize image → 300x300
    final resized = img.copyResize(image, width: 300, height: 300);

    // Create input buffer
    final input = List.generate(
      1,
      (_) => List.generate(
        300,
        (_) => List.generate(
          300,
          (_) => List.filled(3, 0.0),
        ),
      ),
    );

    // Fill buffer with normalized RGB
    for (int y = 0; y < 300; y++) {
      for (int x = 0; x < 300; x++) {
        final pixel = resized.getPixel(x, y);
        input[0][y][x][0] = pixel.r / 255.0;
        input[0][y][x][1] = pixel.g / 255.0;
        input[0][y][x][2] = pixel.b / 255.0;
      }
    }

    // Output buffer [1, numClasses]
    final output = List.filled(classIndices.length, 0.0).reshape([1, classIndices.length]);

    // Run inference
    _interpreter!.run(input, output);

    // Extract logits and apply softmax with temperature
    final logits = List<double>.from(output[0]);
    final probs = _softmax(logits, temperature: temperature);

    // Sort indices by probability
    final sortedIndices = List.generate(probs.length, (i) => i)
      ..sort((a, b) => probs[b].compareTo(probs[a]));

    // Build top N prediction string
    final topPreds = sortedIndices.take(topN).map((i) {
      final label = classIndices[i] ?? "Unknown";
      final probability = (probs[i] * 100).toStringAsFixed(1);
      return "$label ($probability%)";
    }).join("\n");

    return topPreds;
  }

  // -----------------------------
  // SOFTMAX WITH TEMPERATURE
  // -----------------------------
  static List<double> _softmax(List<double> logits, {double temperature = 1.0}) {
    final maxLogit = logits.reduce(max);
    final exps = logits.map((x) => exp((x - maxLogit) / temperature)).toList();
    final sumExps = exps.reduce((a, b) => a + b);
    return exps.map((x) => x / sumExps).toList();
  }
}