import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

import 'firebase/download_model.dart';
import 'services/camera.dart';
import 'services/render_data_yoga.dart';

class PushedPageY extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const PushedPageY({required this.cameras, required this.title});
  @override
  _PushedPageYState createState() => _PushedPageYState();
}

class _PushedPageYState extends State<PushedPageY> {
  List<dynamic> _data = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
   bool _isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    downloadAndLoadModel();
  }
Future<void> downloadAndLoadModel() async {
    try {
      String modelPath = await downloadModel();
      
      var res = await Tflite.loadModel(
        model: modelPath,
        numThreads: 1,
        isAsset: false,
        useGpuDelegate: false,
      );
      
      if (res != "success") {
        throw Exception('Failed to load model');
      }
      
      setState(() {
        _isModelLoaded = true;
      });
    } catch (e) {
    }
  }


  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _data = data;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('My AI Warrior Pose'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Camera(
            cameras: widget.cameras,
            setRecognitions: _setRecognitions,
          ),
          RenderDataYoga(
            data: _data == null ? [] : _data,
            previewH: max(_imageHeight, _imageWidth),
            previewW: min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
          ),
        ],
      ),
    );
  }
}
