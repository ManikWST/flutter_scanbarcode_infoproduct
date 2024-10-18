import 'package:camera/camera.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScannerController {
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;
  bool isScanning = false;
  bool isFlashOn = false;

  Future<void> initializeCamera(List<CameraDescription> cameras) async {
    final camera = cameras.first;
    cameraController = CameraController(camera, ResolutionPreset.medium);
    initializeControllerFuture = cameraController!.initialize();
    await initializeControllerFuture;
  }

  Future<void> toggleFlash() async {
    if (cameraController != null) {
      if (isFlashOn) {
        await cameraController!.setFlashMode(FlashMode.off);
      } else {
        await cameraController!.setFlashMode(FlashMode.torch);
      }
      isFlashOn = !isFlashOn;
    }
  }

  Future<String?> scanBarcodes() async {
    if (!isScanning) return null;

    try {
      final image = await cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

      final barcodes = await barcodeScanner.processImage(inputImage);
      await barcodeScanner.close();

      if (barcodes.isNotEmpty) {
        return barcodes[0].displayValue;
      }
    } catch (e) {
      print('Error scanning barcode: $e');
    }

    return null;
  }

  Future<String?> scanBarcodeFromImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);
        final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

        final barcodes = await barcodeScanner.processImage(inputImage);
        await barcodeScanner.close();

        if (barcodes.isNotEmpty) {
          return barcodes[0].displayValue;
        }
      }
    } catch (e) {
      print('Error scanning barcode from image: $e');
    }

    return null;
  }

  void dispose() {
    isScanning = false;
    cameraController?.dispose();
  }
}
