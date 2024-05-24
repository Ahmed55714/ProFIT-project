import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> downloadModel() async {
  try {
    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create a reference to the model file in Firebase Storage
    Reference ref = FirebaseStorage.instance.ref().child('posenet_mv1_075_float_from_checkpoints.tflite');

    // Download the model file to the temporary directory
    File downloadToFile = File('$tempPath/model.tflite');
    await ref.writeToFile(downloadToFile);

    return downloadToFile.path;
  } catch (e) {
    print("Error downloading model: $e");
    throw e;
  }
}
