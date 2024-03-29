import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:KidsPlan/color.dart';
import 'package:lottie/lottie.dart';

import '../../../../custom/simpleText.dart';
import '../../../../image.dart';
import '../../../../string.dart';
import '../../../initial/view/select_game_screen.dart';
import '../../controller/number/number_puzzle_list_controller.dart';
import 'new_number_slide_solve.dart';
import 'numner_history.dart';

class NumberPuzzleListScreen extends GetView<NumberPuzzleListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NumberPuzzleListController>(
        init: NumberPuzzleListController(),
        builder: (context) {
          return Scaffold(body: _bodyWidget(controller));
        });
  }
}

_bodyWidget(NumberPuzzleListController controller) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Image.asset(
            appselectbg,
            fit: BoxFit.fill,
          )),
        ],
      ),
      SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(SelectGameScreen());
                      },
                      child: Image.asset(appBack)),
                ),
                CustomSimpleTextField(
                  hintText: txtGameLevel,
                  fontfamily: 'summary',
                  textSize: 40,
                  hintColor: appColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(NumberHistoryScreen());
                      },
                      child: Image.asset(appHistory)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.containerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30, bottom: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(NewNumberPuzzleSlideSolveScreen(), arguments: {
                            'numGrid': controller.containerList[index],
                            'boxLength': controller.containerList[index] == '1'
                                ? 9
                                : controller.containerList[index] == '2'
                                    ? 16
                                    : 25,
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: appLightGreenColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.orange,
                                    width: 10,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: CustomSimpleTextField(
                                    textSizeValue: true,
                                    hintText: controller.containerList[index] ==
                                            '1'
                                        ? '3*3'
                                        : controller.containerList[index] == '2'
                                            ? '4*4'
                                            : '5*5',
                                    fontfamily: 'Montstreat',
                                    textSize: 30,
                                    hintColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      // Row(
      //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Hero(tag: 'heroTag',
      //     child: Lottie.asset('assets/robt.json',height: 140,)),
      //     CustomSimpleTextField(
      //       // textSizeValue: true,
      //       textAlign: TextAlign.center,
      //       hintText: controller.text,
      //       textSize:
      //       MediaQuery.of(Get.context!).size.width * 0.06,
      //       hintColor: appPinkColor,
      //       fontfamily: 'summary',
      //     ),
      //   ],
      // ),
    ],
  );
}

showDialogBox(NumberPuzzleListController controller) {
  return showDialog<void>(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('How to play this game!!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Given a name, display multiple"
                " images below. Your task is to select the"
                " correct image that matches the given name. If your selection"
                " is correct,"
                " proceed to the next round; otherwise, display an error message."),
          ],
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              controller.playAudio();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
