import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../contracts/generated/uploadedImageViewModel.dart';
import '../integration/dependencyInjection.dart';
import 'deviceHelper.dart';

void adaptiveImageUploadToServer(
    void Function(UploadedImageViewModel) onSuccess, void Function() onError) {
  adaptiveImageUpload(
    uploadSuccess: (String filename, Uint8List uploadedFile) async {
      var result = await getAssistantAppsUserApi()
          .uploadWebImage([filename], [uploadedFile]);
      result.hasFailed ? onError() : onSuccess(result.value[0]);
    },
    uploadError: onError,
  );
}

void adaptiveImageUpload({
  required void Function(String, Uint8List) uploadSuccess,
  required void Function() uploadError,
}) async {
  if (isWeb) {
    // InputElement uploadInput = FileUploadInputElement();
    // uploadInput.click();

    // uploadInput.onChange.listen((e) {
    //   // read file content as dataURL
    //   final files = uploadInput.files;
    //   if (files.length == 1) {
    //     var file = files[0];
    //     FileReader webReader = FileReader();

    //     webReader.onLoadEnd.listen((e) {
    //       if (uploadSuccess != null) uploadSuccess(file.name, webReader.result);
    //     });

    //     webReader.onError.listen((fileEvent) {
    //       if (uploadError != null) uploadError();
    //     });

    //     webReader.readAsArrayBuffer(file);
    //   }
    // });
  } else {
    final picker = ImagePicker();
    try {
      XFile? pickedFileNative =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFileNative == null) throw Exception('Could not open file');

      Uint8List fileContents = await pickedFileNative.readAsBytes();
      String ext = extension(pickedFileNative.path);
      uploadSuccess('image$ext', fileContents);
    } catch (exception) {
      getLog().e(exception.toString());
      uploadError();
    }
  }
}
