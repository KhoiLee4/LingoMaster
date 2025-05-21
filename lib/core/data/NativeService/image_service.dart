
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' as _client;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

import '../../domain/models/base-reponse.dart';
import '../../domain/models/session.dart';
import 'BaseService.dart';

class ImageService extends BaseService {
  ImageService() : super();

  // Upload multiple images
  Future<BaseResponse> uploadMultipleImages({
    required List<File> files,
    required String cardId,
    required String altText
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url_api/api/Images/UploadMultiple'),
      );

      // Add authorization header
      request.headers.addAll({
        'Authorization': 'Bearer ${Session.token}',
      });

      // Add form fields
      request.fields['cardId'] = cardId;
      request.fields['altText'] = altText;

      // Add files
      for (var file in files) {
        final mimeTypeData = lookupMimeType(file.path);
        final fileExtension = path.extension(file.path).toLowerCase();

        request.files.add(await http.MultipartFile.fromPath(
          'files',
          file.path,
          contentType: MediaType(
            mimeTypeData?.split('/')[0] ?? 'image',
            mimeTypeData?.split('/')[1] ?? (fileExtension.startsWith('.')
                ? fileExtension.substring(1)
                : fileExtension),
          ),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      print('Upload images exception: $e');
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Get images by Card ID
  Future<BaseResponse> getImagesByCardId(String cardId) async {
    try {
      final response = await _client.get(
        Uri.parse('$url_api/api/Images/GetByCardId/$cardId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Update multiple images
  Future<BaseResponse> updateImages({
    required String cardId,
    required List<File> newFiles,
    required List<String> imageIdsToDelete,
    required String altText,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$url_api/api/Images/UpdateMultiple'),
      );

      // Add authorization header
      request.headers.addAll({
        'Authorization': 'Bearer ${Session.token}',
      });

      // Add form fields
      request.fields['cardId'] = cardId;
      request.fields['altText'] = altText;

      // Add imageIdsToDelete
      for (var imageId in imageIdsToDelete) {
        request.fields['imageIdsToDelete'] = imageId;
      }

      // Add files
      for (var file in newFiles) {
        final mimeTypeData = lookupMimeType(file.path);
        final fileExtension = path.extension(file.path).toLowerCase();

        request.files.add(await http.MultipartFile.fromPath(
          'newFiles',
          file.path,
          contentType: MediaType(
            mimeTypeData?.split('/')[0] ?? 'image',
            mimeTypeData?.split('/')[1] ?? (fileExtension.startsWith('.')
                ? fileExtension.substring(1)
                : fileExtension),
          ),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Delete image by ID
  Future<BaseResponse> deleteImage(String imageId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/Images/Delete/$imageId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }

  // Delete images by Card ID
  Future<BaseResponse> deleteImagesByCardId(String cardId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$url_api/api/Images/DeleteByCardId/$cardId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Session.token}',
        },
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return BaseResponse.fromJson(jsonData);
    } catch (e) {
      return BaseResponse(
        Success: false,
        Message: 'Connection error: ${e.toString()}',
      );
    }
  }
}