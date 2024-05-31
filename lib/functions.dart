import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File;


Future saveImage(Uint8List imageData) async {
  PermissionStatus? status = await Permission.storage.request();

  if (status.isGranted) {
    final directory = await getExternalStorageDirectory();
    if (directory != null) {
      final path = directory.path;
      final file = File('$path/downloaded_image.png');
      await file.writeAsBytes(imageData);

      print('Image saved to $path/downloaded_image.png');
      // Show a snackbar or other notification to the user
    }
  } else {
    print('Permission denied');
    // Show a snackbar or other notification to the user
  }
}