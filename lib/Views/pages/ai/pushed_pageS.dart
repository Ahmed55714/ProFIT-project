import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

import '../../../utils/colors.dart';
import '../../widgets/General/custom_loder.dart';
import 'firebase/download_model.dart';
import 'services/camera.dart';
import 'services/render_data.dart';

class PushedPageS extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  const PushedPageS({required this.cameras, required this.title});
  @override
  _PushedPageSState createState() => _PushedPageSState();
}

class _PushedPageSState extends State<PushedPageS> {
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
      print('Starting model download');
      String modelPath = await downloadModel();
      print('Model downloaded to: $modelPath');
      
      var res = await Tflite.loadModel(
        model: modelPath,
        numThreads: 1,
        isAsset: false,
        useGpuDelegate: false,
      );
      
      if (res != "success") {
        print('Failed to load model: $res');
        throw Exception('Failed to load model');
      }
      
      print('Model loaded successfully');
      setState(() {
        _isModelLoaded = true;
      });
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted || !_isModelLoaded) {
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
        title: Text('My AI Squat'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isModelLoaded ? Stack(
        children: <Widget>[
          Camera(
            cameras: widget.cameras,
            setRecognitions: _setRecognitions,
          ),
          RenderData(
            data: _data == null ? [] : _data,
            previewH: max(_imageHeight, _imageWidth),
            previewW: min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
          ),
        ],
      ) : Center(child: CustomLoder(
        color:  colorBlue,
        size: 35,
      )),
    );
  }
}
