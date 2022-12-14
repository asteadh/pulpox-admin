import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pulpox_admin/controllers/LoginController/login_controller.dart';

import '../routes/app_pages.dart';
import 'auth_dialog/auth_dialog.dart';
import 'package:flutter/material.dart';

import 'platformButtons/profileLoginButtons.dart';

class TopBarContents extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final LoginController controller =
        Get.put<LoginController>(LoginController());
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(0),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.main);
                },
                child: Text(
                  'PulPox',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    InkWell(
                      onHover: (value) {
                        // setState(() {
                        value
                            ? controller.isHovering[0] = true
                            : controller.isHovering[0] = false;
                        // });
                      },
                      onTap: () {
                        Get.toNamed(AppPages.aboutUs);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                              color: controller.isHovering[0]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: controller.isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        // setState(() {
                        value
                            ? controller.isHovering[1] = true
                            : controller.isHovering[1] = false;
                        // });
                      },
                      onTap: () {
                        Get.toNamed(AppPages.contactUS);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              color: controller.isHovering[1]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: controller.isHovering[1],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    FirebaseAuth.instance.currentUser != null
                        ? Row(
                            children: [
                              SizedBox(width: screenSize.width / 20),
                              InkWell(
                                onHover: (value) {
                                  // setState(() {
                                  value
                                      ? controller.isHovering[2] = true
                                      : controller.isHovering[2] = false;
                                  // });
                                },
                                onTap: () {
                                  Get.toNamed(AppPages.platform);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Administracci??n',
                                      style: TextStyle(
                                        color: controller.isHovering[2]
                                            ? Colors.blue[200]
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Visibility(
                                      maintainAnimation: true,
                                      maintainState: true,
                                      maintainSize: true,
                                      visible: controller.isHovering[2],
                                      child: Container(
                                        height: 2,
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.brightness_6),
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   color: Colors.white,
              //   onPressed: () {
              //     //Change Theme Mode
              //     // EasyDynamicTheme.of(context).changeTheme();
              //     Get.changeThemeMode(ThemeService().loadThemeFromBox()
              //         ? ThemeMode.light
              //         : ThemeMode.dark);
              //     ThemeService()
              //         .saveThemeToBox(!ThemeService().loadThemeFromBox());
              //   },
              // ),
              // SizedBox(
              //   width: screenSize.width / 50,
              // ),
              Row(
                children: [
                  FirebaseAuth.instance.currentUser != null
                      ? Container(height: 60, child: ProfileFotoSignOutButton())
                      : SizedBox.shrink(),
                  // SizedBox(
                  //   width: screenSize.width / 50,
                  // ),
                  InkWell(
                      onHover: (value) {
                        // setState(() {
                        value
                            ? controller.isHovering[3] = true
                            : controller.isHovering[3] = false;
                        // });
                      },
                      onTap:
                          //  userEmail == null
                          //     ?
                          () {
                        showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );
                      }
                      // : null
                      ,
                      child: FirebaseAuth.instance.currentUser == null
                          ? Text(
                              'Sign in',
                              style: TextStyle(
                                color: controller.isHovering[3]
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          : SizedBox.shrink()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
