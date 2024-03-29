import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:KidsPlan/pages/home/view/spelling/select_spelling_screen.dart';

import '../../../../color.dart';
import '../../../../custom/simpleText.dart';
import '../../../../image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../string.dart';
import '../../../initial/view/select_game_screen.dart';
import '../../controller/spelling/spelling_grid_controller.dart';

class SpellingGridScreen extends GetView<SpellingGridController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpellingGridController>(
        init: SpellingGridController(),
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                Get.to(SelectGameScreen());
                return true;
              },
              child: Scaffold(body: _bodyWidget(controller)));
        });
  }
}

_bodyWidget(SpellingGridController controller) {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Image.asset(
            appgameBg,
            fit: BoxFit.fill,
          )),
        ],
      ),
      SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Get.offAllNamed(AppRoutes.selectGameScreen);
                              },
                              child: Image.asset(appBack)),
                        ),
                        Flexible(
                          child: CustomSimpleTextField(
                            hintText: 'Welcome, ${
                                controller.truncateText(
                                    '${controller.AvtarName}!',11
                                )
                            } ',
                            // hintText: 'Welcome, ${controller.AvtarName}!!!',
                            textSize: 35,
                            hintColor: appyellowColor,
                            fontfamily: 'summary',
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        )
                      ],
                    ),
                    Flexible(
                      child: CustomSimpleTextField(
                        hintText: txtGameSelect,
                        textSize: MediaQuery.of(Get.context!).size.width * 0.05,
                        hintColor: blackColor,
                        fontfamily: 'summary',
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  itemCount: controller.yourDataList.length,
                  // Replace with your actual data list length
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.playAudio();
                          Get.to(SelectSpellingScreen(), arguments: {
                            'roleId': controller.yourDataList[index].roleId,
                          });
                          print(controller.yourDataList[index].roleId);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient:
                                  controller.yourDataList[index].gradientColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                controller.yourDataList[index].imageUrl,
                                // Replace with the image URL from your data model
                                height: 80, // Adjust the height as needed
                                width: 80, // Adjust the width as needed
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              Flexible(
                                child: CustomSimpleTextField(
                                  hintText: controller.yourDataList[index].name,
                                  textSize: 20,
                                  hintColor: Colors.white,
                                  fontfamily: 'summary',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ); // Replace with your data model
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
