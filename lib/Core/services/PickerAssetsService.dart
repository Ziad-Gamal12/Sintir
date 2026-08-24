import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:image_picker/image_picker.dart';

class PickerAssetsService {
  final ImagePicker picker = ImagePicker();

  Future<File?> getImage({
    required ImageSource source,
  }) async {
    final XFile? pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  Future<File?> getVideo({
    required ImageSource source,
  }) async {
    final XFile? pickedFile = await picker.pickVideo(
      source: source,
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  Future<File?> getFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'Files',
      extensions: [
        'pdf',
        'doc',
        'docx',
        'txt',
        'ppt',
        'pptx',
        'xls',
        'xlsx',
      ],
    );

    final XFile? pickedFile = await openFile(
      acceptedTypeGroups: [typeGroup],
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }
}
