import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File> compressAndResizeImage(File file, {int quality = 70}) async {
  final tempDir = await getTemporaryDirectory();
  final targetPath = '${tempDir.path}/processed_${file.path.split('/').last}';

  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: quality,
    minWidth: 600, // Minimum width after resize
    //minHeight: 1000, // Minimum height after resize
  );

  return File(result!.path);
}