import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../network/api_helper.dart';
import 'camerabottomsheet.dart';

class ImageUpload{

  Future<String> postImage(BuildContext context) async {

    XFile file = await CameraBottomsheet().show(context);
    String response = await ApiHelper().uploadImage(file);
    response = response.replaceAll("\"", "");
    return response;
  }



}


