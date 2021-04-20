import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:get/get.dart';

class ScannerPage extends StatefulWidget {

  static final String routeName = '/scanner';

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  bool _resultSent = false;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CameraMlVision<List<Barcode>>(
        loadingBuilder: (context) => Container(),
        detector: FirebaseVision.instance.barcodeDetector(
            BarcodeDetectorOptions(barcodeFormats: BarcodeFormat.pdf417)
        ).detectInImage,
        onResult: (List<Barcode> barcodes) {
          if (!mounted || _resultSent) return;
          if (barcodes.isEmpty) return;
          for(Barcode barcode in barcodes) {
            if(barcode.driverLicense != null) {
              _resultSent = true;
              Get.back(result: barcode.driverLicense);
            }
          }
        },
      ),
      fit: BoxFit.fill,
    );
  }
}

