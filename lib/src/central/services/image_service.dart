import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'my_logger.dart';

class ImageService extends GetxController {
  //Image Service
  final _picker = ImagePicker();

  Future getPhotoFromCamera({bool allowCrop = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        if (!allowCrop) {
          return pickedFile;
        }
     
      } else {
        return;
      }
    } catch (e) {
      logger.e('getImageFromCamera error: ${e.toString()}');
    }
  }

  Future getImagesFromGallery() async {
    final List<XFile>? galleryImagesList = await _picker.pickMultiImage(
      imageQuality: 50,
    );
    if (galleryImagesList != null) {
      return galleryImagesList;
    }
  }
}
