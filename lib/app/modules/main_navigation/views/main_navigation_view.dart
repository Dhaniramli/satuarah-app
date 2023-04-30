import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavigationController>(
      init: MainNavigationController(),
      builder: (controller) {
        controller.view = this;

        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Text(
                    "Selectted: ${controller.selectedIndex}",
                    style: TextStyle(
                      fontSize: 20,
                      color: black,
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    height: MediaQuery.of(context).size.height,
                    child: IndexedStack(
                      index: controller.selectedIndex,
                      children: [
                        HomeView(),
                        Container(
                          color: Colors.red,
                        ),
                        Container(
                          color: Colors.blue,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    left: 0.0,
                    bottom: 0.0,
                    height: 76.0,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          top: BorderSide(
                            color: primaryColor,
                            width: 4.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        color: white,
                      ),
                      child: Row(
                        children: List.generate(
                          controller.menuList.length,
                          (index) {
                            var item = controller.menuList[index];
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.selectedIndex = index;
                                  controller.update();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "${item['icon']}",
                                      width: 30.0,
                                      height: 30.0,
                                      fit: BoxFit.fill,
                                      color: controller.selectedIndex == index
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      "${item['label']}",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: semiBold,
                                        color: controller.selectedIndex == index
                                            ? primaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
