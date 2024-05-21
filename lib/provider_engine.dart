import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/secret_const.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class MainEngine extends ChangeNotifier {
  bool? loadingBool = false;
  FirebaseAuth? _firebaseAuth;
  String? currentUserEmail;
  FirebaseFirestore? _firestore;
  StabilityAI? _ai;





  Future<Uint8List> imageCreation(String? prompt)async{
    var data = await _firestore!
        .collection('users')
        .doc("$currentUserEmail").get();
    _ai = await StabilityAI();
    Uint8List image = await _ai!.generateImage(
      apiKey: "",
      imageAIStyle: ImageAIStyle.render3D,
      prompt: prompt!,
    );
    return image;


  }

  Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
    await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  void intializeApp() async {
    updateLoadingState(true);
    if (await checkConnection()) {
      try {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: firebaseAPI,
            appId: '1:800372853175:android:03e3917b12f9c2891c4032',
            messagingSenderId: 'sendid',
            projectId: 'futuregenai',
            storageBucket: 'myapp-b9yt18.appspot.com',
          ),
        );
        _firebaseAuth = FirebaseAuth.instance;
        _firestore = FirebaseFirestore.instance;
        updateLoadingState(false);
      } catch (e) {
        updateLoadingState(false);
        showSnackBar(ContentType.help, "Server Error",
            "There is an internal error for connecting to the server");
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
    }
  }

  Future<bool> signUP(String? email, String? password) async {
    updateLoadingState(true);
    if (await checkConnection()) {
      try {
        print('reached here');
        final newUser = await _firebaseAuth!
            .createUserWithEmailAndPassword(email: email!, password: password!);

        if (newUser != null) {
          currentUserEmail = email;
          createCollection();
          updateLoadingState(false);
          showSnackBar(ContentType.success, "Success", "Successfully SignedUP");
          return true;
        } else {
          updateLoadingState(false);
          showSnackBar(ContentType.failure, "Failed", "Failed to create user");
          return false;
        }
      } catch (e) {
        updateLoadingState(false);
        showSnackBar(ContentType.failure, "Failed", "$e");
        return false;
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
      return false;
    }
  }

  Future<bool> signIN(String? email, String? password) async {
    updateLoadingState(true);
    if (await checkConnection()) {
      try {
        final user = await _firebaseAuth!
            .signInWithEmailAndPassword(email: email!, password: password!);

        if (user != null) {
          currentUserEmail = email;
          updateLoadingState(false);
          showSnackBar(
              ContentType.success, "Success", "Successfully Signed In");
          return true;
        } else {
          updateLoadingState(false);
          showSnackBar(ContentType.failure, "Failed", "Failed to Sign In");
          return false;
        }
      } catch (e) {
        updateLoadingState(false);
        showSnackBar(ContentType.failure, "Failed", "$e");
        return false;
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
      return false;
    }
  }

  Future<bool> updateAPI(String? api) async {
    await _firestore!
        .collection('users')
        .doc("$currentUserEmail")
        .update({"api": "$api"});
    return true;
  }

  void createCollection() {
    _firestore!
        .collection('users')
        .doc("$currentUserEmail")
        .set({"api": ""});
  }

  void updateLoadingState(bool? changeValue) {
    loadingBool = changeValue;
    notifyListeners();
  }

  bool? getLoadingBool() {
    return loadingBool;
  }

  void showSnackBar(
      ContentType contentType, String snackBarTitle, String snackBarMessage) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: snackBarTitle,
        message: snackBarMessage,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
