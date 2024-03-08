import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter_hr_management/organization_portal/model/gallary_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

class GalleryProvider extends ChangeNotifier{
  List<Gallery> imageList = [];
  var response;
  int totalPages = 0;
  bool isLoading = false;

  Future<GalleryModel> getCard({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();

    if(currentPage == 0){
      imageList.clear();
    }
    String myUrl = AppConstants.GALLERY +'?page=${currentPage}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    var type = GalleryModel.fromJson(response);
    imageList.addAll(type.content);
    notifyListeners();
    return type;
  }
  
  postGallery({String? topicName,String? userId,io.File? imageFile,String? description, String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {

    String myUrl = AppConstants.GALLERY;

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "imageFile", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));
    request.fields['topicName'] = topicName!;
    request.fields['description'] = description!;
    request.fields['userId'] = userId!;
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var jsonData = jsonDecode(value);
      Gallery routeData = Gallery.fromJson(jsonData);
      imageList.add(routeData);
      notifyListeners();
    });

   /* var jsonData = jsonDecode(response.body);
    Gallery routeData = Gallery.fromJson(jsonData);
    imageList.add(routeData);*/

  }

  deleteGallery(Gallery gallery) async {
    String myUrl = AppConstants.GALLERY +'?id=${gallery.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    imageList.remove(gallery);
    notifyListeners();
  }

  String? image;
  Future setImage(img) async{
    this.image = img;
    this.notifyListeners();
  }
}