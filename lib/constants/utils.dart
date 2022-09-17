import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  
  List<File> images = [];

  try {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (file != null && file.files.isNotEmpty) {
      for (var i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint("The error related to utils pick images $e");
  }
  return images;
}
