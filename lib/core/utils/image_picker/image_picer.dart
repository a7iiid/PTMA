import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PickImageServes {
  File? file;
  String? url;
  late var imagename;
  static PickImageServes get() => PickImageServes();

  Future<String> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      file = File(photo.path);
      var imagename = basename(photo.path);

      var uplode = FirebaseStorage.instance.ref('/user_pictiors/$imagename');
      await uplode.putFile(file!);
      url = await uplode.getDownloadURL();
      return url!;
    } else {
      return 'no image';
    }
  }

  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      imagename = basename(image.path);

      // var uplode = FirebaseStorage.instance.ref('/user_pictiors/$imagename');
      // await uplode.putFile(file!);
      // url = await uplode.getDownloadURL();
    } else {
      return;
    }
  }

  Future<void> uplode() async {
    var uplode = FirebaseStorage.instance.ref('/user_pictiors/$imagename');
    await uplode.putFile(file!);
    url = await uplode.getDownloadURL();
  }
}
