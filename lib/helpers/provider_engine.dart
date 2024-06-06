import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/helpers/secret_const.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'network.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class MainEngine extends ChangeNotifier {
  bool? loadingBool = false;
  FirebaseAuth? _firebaseAuth;
  String? currentUserEmail;
  FirebaseFirestore? _firestore;
  Uint8List? welcomePageBG;
  var streamFirestoreSnapshot;

  Future<Uint8List> imageCreation(String? prompt) async {
    Uint8List image = await getData(prompt!);
    await _firestore!
        .collection('users')
        .doc("$currentUserEmail")
        .collection('prompts').add({"prompts": base64Encode(image)});
    updateSnapshot();
    return image;
  }

  Future<Uint8List?> imageCreationForBackground() async {

    if (await checkConnection()) {
      try {
        Uint8List image = await getData('Blueish AI Robot planet with Alien Infront of the view');
        return image;
      } catch (e) {
        showSnackBar(ContentType.failure, "Failed", "$e  hellooooooooo");
        return null; // Return null in case of error
      }
    } else {
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
      return null; // Return null if there is no network connection
    }
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
            appId: firebaseAppID,
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
        showSnackBar(ContentType.help, "ServerError",
            "There is an internal error for connecting to the server");
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
    }
  }

  Future<List> signUP(String? email, String? password) async {
    updateLoadingState(true);
    if (await checkConnection()) {
      try {
        final newUser = await _firebaseAuth!
            .createUserWithEmailAndPassword(email: email!, password: password!);
        if (newUser != null) {
          currentUserEmail = email;
          createCollection();
          showSnackBar(ContentType.success, "Success", "Successfully SignedUP");
          Uint8List imagePath = await imageCreation('a futuristic lady potrait in an artistic view');
          updateLoadingState(false);
          return [imagePath,true];
        } else {
          updateLoadingState(false);
          showSnackBar(ContentType.failure, "Failed", "Failed to create user");
          return [null,false];
        }
      } catch (e) {
        updateLoadingState(false);
        showSnackBar(ContentType.failure, "Failed", "$e");
        return [null,false];
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
      return [null,false];
    }
  }

  Future<List> signIN(String? email, String? password) async {
    updateLoadingState(true);
    if (await checkConnection()) {
      try {
        final user = await _firebaseAuth!
            .signInWithEmailAndPassword(email: email!, password: password!);

        if (user != null) {
          currentUserEmail = email;
          showSnackBar(
              ContentType.success, "Success", "Successfully Signed In");
          Uint8List imagePath = await imageCreation('a futuristic lady potrait in an artistic view');
          updateLoadingState(false);
          return [imagePath,true];
        } else {
          updateLoadingState(false);
          showSnackBar(ContentType.failure, "Failed", "Failed to Sign In");
          return [null,false];
        }
      } catch (e) {
        updateLoadingState(false);
        showSnackBar(ContentType.failure, "Failed", "$e");
        return [null,false];
      }
    } else {
      updateLoadingState(false);
      showSnackBar(ContentType.failure, "Network Error",
          "Please check your network connection and try again");
      return [null,false];
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
    _firestore!.collection('users').doc("$currentUserEmail").set({"promptID": ""});
  }

  void updateLoadingState(bool? changeValue) {
    loadingBool = changeValue;
    notifyListeners();
  }

  bool? getLoadingBool() {
    return loadingBool;
  }

  void updateSnapshot(){
    streamFirestoreSnapshot = _firestore!
        .collection('users')
        .doc(currentUserEmail)
        .collection("prompts")
        .snapshots();
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
