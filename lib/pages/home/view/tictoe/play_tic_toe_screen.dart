import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../color.dart';
import '../../../../custom/simpleText.dart';
import '../../../../image.dart';
import '../../../../string.dart';
import '../../controller/tictoe/play_tic_toe_controller.dart';

class PlayTicToeScreen extends GetView<PlayTicToeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<PlayTicToeController>(
            init: PlayTicToeController(),
            builder: (context) {
              return Scaffold(body: _bodyWidget(controller));
            }),
        onWillPop: () async {
          controller.togglePlayPause();
          return true;
          // return false;
        });
  }
}

_bodyWidget(PlayTicToeController controller) {
  return Stack(
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
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.playAudio();
                          controller.togglePlayPause();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              controller.isTimerPaused
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Container(
                      width: 150,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: 50,
                            // Adjust the distance between the circle and text
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Colors.pink,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    controller
                                        .formatTime(controller.secondsElapsed),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.amber,
                            backgroundImage: AssetImage(appalarm),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.playAudio();
                          showDialogBox(controller);
                        },
                        child: Image.asset(appTips)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: SafeArea(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                height: 100,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: appColor,
                                      radius: 60,
                                      child: Image.asset(
                                          controller
                                                  .selectedItem1?.imageAsset ??
                                              '',
                                          width: 70,
                                          height: 70),
                                    ),
                                    Positioned(
                                      bottom: 2, // Use bottom instead of top
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15),
                                          child: Center(
                                            child: CustomSimpleTextField(
                                              textSizeValue: true,
                                              hintText: controller
                                                      .selectedItem1?.text ??
                                                  "",
                                              textSize: 20,
                                              hintColor: Colors.white,
                                              fontfamily: 'summary',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomSimpleTextField(
                                    hintText: txtVS,
                                    textSize: 35,
                                    hintColor: appColor,
                                    fontfamily: 'summary',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                height: 100,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // Container(
                                    //   height: 60,
                                    //   color: Colors.white,
                                    // ),
                                    CircleAvatar(
                                      backgroundColor: appColor,
                                      radius: 60,
                                      child: Image.asset(
                                          controller.selectedItem?.imageAsset ??
                                              "",
                                          width: 70,
                                          height: 70),
                                    ),
                                    Positioned(
                                      bottom: 2, // Use bottom instead of top
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15),
                                          child: Center(
                                            child: CustomSimpleTextField(
                                              textSizeValue: true,
                                              hintText: controller
                                                      .selectedItem?.text ??
                                                  "",
                                              textSize: 20,
                                              hintColor: Colors.white,
                                              fontfamily: 'summary',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      ConfettiWidget(
                        confettiController: controller.blastController,
                        shouldLoop: true,
                        blastDirectionality: BlastDirectionality.explosive,
                        maxBlastForce: 100,
                        numberOfParticles: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomSimpleTextField(
                            textSizeValue: true,
                            hintText:
                                '${controller.player2Wins}-${controller.numSeries}',
                            textSize: 30,
                            hintColor: appColor,
                            fontfamily: 'Monstreat',
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          CustomSimpleTextField(
                            textSizeValue: true,
                            hintText:
                                '${controller.player1Wins}-${controller.numSeries}',
                            textSize: 30,
                            hintColor: appColor,
                            fontfamily: 'Monstreat',
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomSimpleTextField(
                          textSizeValue: true,
                          hintText: controller.playerTurnName == ''
                              ? controller.nextMatchName == 1
                                  ? controller.playerX == false
                                      ? '''Player ${controller.selectedItem!.text}'s turn'''
                                          ''
                                      : '''Player ${controller.selectedItem1!.text}'s turn'''
                                          ''
                                  : ''
                              // ? controller.nextMatchName == 1
                              //     ? '''Player ${controller.selectedItem1!.text}'s turn'''
                              //         ''
                              //     : ''
                              : '''Player ${controller.playerTurnName ?? controller.selectedItem1!.text}'s turn'''
                                  '',
                          textSize: 30,
                          hintColor: appColor,
                          fontfamily: 'summary',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [shadow],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemCount: 9,
                              itemBuilder: (BuildContext context, int index) {
                                int row = index ~/ 3;
                                int col = index % 3;
                                String cellContent = controller.board[row][col];
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.winner != null) {
                                      return null;
                                    } else if (cellContent == '') {
                                      controller.nextMatchName = 0;

                                      controller.board[row][col] =
                                          controller.playerX ? 'O' : 'X';
                                      controller.playerX = !controller.playerX;
                                      controller.checkForWinner();
                                      controller.congratulationsPopupShown =
                                          false;

                                      print(controller.playerX);
                                      controller.playerX == false
                                          ? controller.playerTurnName =
                                              controller.selectedItem!.text
                                          : controller.playerTurnName =
                                              controller.selectedItem1!.text;
                                      controller.winner != null
                                          ? controller.playerTurnName = ''
                                          : '';
                                      controller.update();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: appLightGreyColor,
                                              width: col > 0 ? 1.0 : 0.0),
                                          top: BorderSide(
                                              color: appLightGreyColor,
                                              width: row > 0 ? 2.0 : 0.0),
                                          right: BorderSide(
                                              color: appLightGreyColor,
                                              width: col < 2 ? 1.0 : 0.0),
                                          bottom: BorderSide(
                                              color: appLightGreyColor,
                                              width: row < 2 ? 1.0 : 0.0),
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Center(
                                        child: cellContent == 'X'
                                            ? Image.asset(
                                                controller.selectedItem
                                                        ?.imageAsset ??
                                                    "",
                                                width: 80,
                                                height: 80)
                                            : cellContent == 'O'
                                                ? Image.asset(
                                                    controller.selectedItem1
                                                            ?.imageAsset ??
                                                        '',
                                                    width: 70,
                                                    height: 70)
                                                : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          if (controller.winner != null)
                            controller.buildEndGameUI(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

showDialogBox(PlayTicToeController controller) {
  return showDialog<void>(
    context: Get.context!,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(apphow),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(Get.context!).size.height * 0.01),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width * 0.6,
                  // height: MediaQuery.of(Get.context!).size.height * 0.2,
                  child: CustomSimpleTextField(
                    textAlign: TextAlign.center,
                    hintText:
                        "Players take turns placing P1 or P2 in a 3x3 grid."
                        " The first to get three in a row wins, either horizontally,"
                        " vertically, or diagonally. If the grid fills up without a winner,"
                        " it's a draw.s",
                    textSize: MediaQuery.of(Get.context!).size.width * 0.04,
                    hintColor: blackColor,
                    fontfamily: 'Monstreat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    controller.playAudio();
                    Get.back();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        appbtn,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                      Center(
                        child: CustomSimpleTextField(
                          textAlign: TextAlign.center,
                          hintText: 'OKAY!!',
                          textSize:
                              MediaQuery.of(Get.context!).size.width * 0.06,
                          hintColor: Colors.white,
                          fontfamily: 'summary',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
