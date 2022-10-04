import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../contracts/results/resultWithValue.dart';
import '../contracts/generated/uploadedImageViewModel.dart';
import '../integration/dependencyInjection.dart';
import 'deviceHelper.dart';

void adaptiveImageUploadToServer(
    void Function(UploadedImageViewModel) onSuccess,
    void Function(String) onError) {
  adaptiveImageUpload(
    onSuccessfulFileRead: (String filename, Uint8List uploadedFile) async {
      ResultWithValue<List<UploadedImageViewModel>> result =
          await getAssistantAppsUserApi()
              .uploadWebImage([filename], [uploadedFile]);
      result.hasFailed
          ? onError(result.errorMessage) //
          : onSuccess(result.value[0]);
    },
    uploadError: onError,
  );
}

void adaptiveImageUpload({
  required void Function(String, Uint8List) onSuccessfulFileRead,
  required void Function(String) uploadError,
}) async {
  try {
    Uint8List? fileContents;
    String? ext;
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
    } else if (isDesktop) {
      FilePickerResult? myFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (myFile == null || myFile.files.length < 1) {
        getLog().e('pickFiles result is null');
        uploadError('pickFiles result is null');
        return;
      }
      fileContents = myFile.files[0].bytes; //.toUint8List();
    } else if (isAndroid || isiOS) {
      ImagePicker picker = ImagePicker();
      XFile? pickedFileNative =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFileNative == null) throw Exception('Could not open file');

      fileContents = await pickedFileNative.readAsBytes();
      ext = extension(pickedFileNative.path);
    }

    if (fileContents == null) {
      getLog().e('fileContents are null');
      uploadError('fileContents are null');
      return;
    }

    onSuccessfulFileRead('image$ext', fileContents);
  } catch (exception) {
    getLog().e(exception.toString());
    uploadError(exception.toString());
  }
}
