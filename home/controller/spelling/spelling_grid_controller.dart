import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app_argument.dart';
import '../../../../color.dart';
import '../../../../image.dart';

class SpellingGridController extends GetxController {
  String text = "";
  int index = 0;
  final String fullText = '''Hello,let's have a\nquick spelling session!''';
  bool isNumberPuzzleRobotShown = false;
  final box = GetStorage();

  void startTyping() {
    const duration = const Duration(milliseconds: 100);

    Timer.periodic(duration, (timer) {
      if (index < fullText.length) {
        text += fullText[index];
        index++;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    AvtarName = userData.read(userName);
    startTyping();
    box.initStorage;
    isNumberPuzzleRobotShown = box.read('isSpellingGameRobotShown') ?? false;
    super.onInit();
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  final userData = GetStorage();
  var AvtarName;
  String audioPath = 'audio/click.mp3';

  void playAudio() async {
    try {
      await audioPlayer.play(AssetSource(audioPath));
      print('Audio playing');
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  String? truncateText(String? text, int maxLength) {
    if (text != null && text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    } else {
      return text;
    }
  }

  List<YourDataModel> yourDataList = [
    YourDataModel(
        roleId: "1",
        imageUrl: appGcolor,
        name: 'Colors',
        gradientColor: appGradient4),
    YourDataModel(
        roleId: "2",
        imageUrl: appGveg,
        name: 'Vegetable',
        gradientColor: appGradient2),
    YourDataModel(
        roleId: "3",
        imageUrl: appGbody,
        name: 'Body Parts',
        gradientColor: appGradient1),

    // Add more items as needed
  ];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
  }
}

class YourDataModel {
  final String imageUrl;
  final String roleId;
  final String name;
  final Gradient gradientColor;

  YourDataModel(
      {required this.imageUrl,
      required this.roleId,
      required this.name,
      required this.gradientColor});
}
