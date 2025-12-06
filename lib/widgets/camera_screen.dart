import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../utils/prediction_service.dart';
import 'prediction_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isPredicting = false;

  Future<void> _analyzeImage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file == null) return;

    setState(() => _isPredicting = true);

    final bytes = await File(file.path).readAsBytes();
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to decode image")),
      );
      setState(() => _isPredicting = false);
      return;
    }

    final prediction = await PredictionService.predict(decoded);

    setState(() => _isPredicting = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PredictionScreen(
          imageFile: File(file.path),
          prediction: prediction,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skin Lesion Analyzer")),
      body: Center(
        child: _isPredicting
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Analyzing Image..."),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _analyzeImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Capture Image"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _analyzeImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Pick from Gallery"),
                  ),
                ],
              ),
      ),
    );
  }
}