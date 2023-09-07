import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:images_picker/images_picker.dart';
import 'package:mime/mime.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/loading_widget.dart';
import 'app_textstyles.dart';
import 'colors.dart';
class Functions {
  static push(BuildContext context, Widget widget) {
    // PersistentNavBarNavigator.pushNewScreen(
    //   context,
    //   screen: widget,
    // );

    context.push(child: widget);
  }

  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: widget,
    );
  }

  static showToast(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      backgroundColor: CColors.primary,
      fontSize: 12,
    );
  }

  static showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      duration: const Duration(milliseconds: 800),
      content: Text(
        message,
        style: AppTextStyles.poppins(
          style: TextStyle(
            color: CColors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: CColors.primary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(kDebugMode);
          },
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: LoadingWidget(),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static Future<String> uploadImage(File file, {required String path}) async {
    try {
      final firebasestorage.FirebaseStorage _storage =
          firebasestorage.FirebaseStorage.instance;
      var reference = _storage.ref().child(path);
      var r = await reference.putFile(file, SettableMetadata());
      if (r.state == firebasestorage.TaskState.success) {
        String url = await reference.getDownloadURL();
        return url;
      } else {
        throw PlatformException(code: "404", message: "no download link found");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadFile(File file, {required String path}) async {
    try {
      final mimeType = lookupMimeType(file.path);
      print(mimeType);
      final firebasestorage.FirebaseStorage _storage =
          firebasestorage.FirebaseStorage.instance;
      var reference = _storage.ref().child(path);
      var r = await reference.putData(
          await file.readAsBytes(), SettableMetadata(contentType: mimeType));

      if (r.state == firebasestorage.TaskState.success) {
        String url = await reference.getDownloadURL();
        return url;
      } else {
        throw PlatformException(code: "404", message: "no download link found");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<File?> pickImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      cropOpt: CropOption(),
    );

    if (res != null && res.isNotEmpty) {
      return File(res.first.path);
    }
  }
}
