import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:travelhive/services/user_collection_service.dart';

class UploadService {

  static const String ip = "http://110.93.247.8:3000";

  Future<String> uploadImageToServer(XFile image) async {
    try {
      final file = File(image.path);
      final uri = Uri.parse('${ip}/upload');
      final request = http.MultipartRequest('POST', uri);
      final mimeTypeData = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          file.path,
          contentType: mimeTypeData != null
              ? MediaType(mimeTypeData[0], mimeTypeData[1])
              : null,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final responseBody = jsonDecode(responseData.body);
        return responseBody['url'];
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw e.toString();
    }
  }


  Future<String> uploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        throw Exception("No image selected");
      }

      final file = File(pickedFile.path);
      final uri = Uri.parse('${ip}/upload');
      final request = http.MultipartRequest('POST', uri);
      final mimeTypeData = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          file.path,
          contentType: mimeTypeData != null
              ? MediaType(mimeTypeData[0], mimeTypeData[1])
              : null,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final responseBody = jsonDecode(responseData.body);
        return responseBody['url'];
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> updateImageInCollection(String uid) async {

    try {
      final imageUrl = await uploadImage();
      UserCollectionService().updateUserPhoto(uid: uid, url: "${ip}${imageUrl}");
      return "${ip}${imageUrl}";
    } catch (e) {
      return e.toString();
    }


  }


}
