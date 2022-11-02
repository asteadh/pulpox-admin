import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

import '../controllers/LoginController/login_controller.dart';
import '../routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'auth_dialog/auth_dialog.dart';

class ExploreDrawer extends StatefulWidget {
  @override
  State<ExploreDrawer> createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  final LoginController controller =
      Get.put<LoginController>(LoginController());

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // controller.myUser!.foto;
    return Drawer(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Login_information(),
              SizedBox(height: 20),
              // controller.userEmail != null ? SizedBox(height: 20) : Container(),
              InkWell(
                onTap: () {
                  Get.toNamed(AppPages.aboutUs);
                  // LandingPageBase()
                },
                child: Text(
                  'About Us',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppPages.contactUS);
                },
                child: Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              AdministraccionEnableWidget(),
              Expanded(child: SizedBox.shrink()),
              UserLoginWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Copyright © 2022 | PulPox SpA',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Login_information extends StatelessWidget {
  const Login_information({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://scaffoldtecnologia.com.br/wp-content/uploads/2021/10/app-2dd.png";
    return FirebaseAuth.instance.currentUser != null
        ? Container(
            // height: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * .05,
                  child: ImageNetwork(
                    image: imageUrl,
                    imageCache: CachedNetworkImageProvider(imageUrl),
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.height * .05,
                    duration: 1500,
                    curve: Curves.easeIn,
                    onPointer: true,
                    debugPrint: false,
                    fullScreen: false,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover,
                    borderRadius: BorderRadius.circular(70),
                    onLoading: const CircularProgressIndicator(
                      color: Colors.indigoAccent,
                    ),
                    onError: Icon(
                      size: (MediaQuery.of(context).size.height * .05),
                      Icons.person,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      debugPrint("Error de Texto");
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                ),
                NameLandingUser()
              ],
            ),
          )
        : SizedBox.shrink();
  }
}

class NameLandingUser extends StatefulWidget {
  const NameLandingUser({
    Key? key,
  }) : super(key: key);

  @override
  State<NameLandingUser> createState() => _NameLandingUserState();
}

class _NameLandingUserState extends State<NameLandingUser> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put<LoginController>(LoginController());
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          child: userController.myUser?.nombre == null
              ? Icon(
                  Icons.account_circle,
                  size: 20,
                  color: Colors.grey,
                )
              : Container(
                  width: 170,
                  child: AutoSizeText(userController.myUser?.nombre,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          child: userController.myUser?.nombre == null
              ? Icon(
                  Icons.account_circle,
                  size: 20,
                  color: Colors.grey,
                )
              : Container(
                  width: 160,
                  child: AutoSizeText(userController.myUser?.correo,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white24,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
        ),
      ],
    );
  }
}

class AdministraccionEnableWidget extends StatelessWidget {
  const AdministraccionEnableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.blueGrey[400],
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppPages.platform);
                },
                child: Text(
                  'Administracción',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}

class UserLoginWidget extends StatelessWidget {
  const UserLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null
        ? Container(
            width: double.maxFinite,
            child: TextButton(
              // color: Colors.black,
              // hoverColor: Colors.blueGrey[800],
              // highlightColor: Colors.blueGrey[700],
              style: TextButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                LoginController().signOut();
              },
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15),
              // ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage: controller.myUser?.foto != null
                    //       ? NetworkImage(controller.myUser?.foto)
                    //       : null,
                    //   child: controller.myUser?.foto == null
                    //       ? Icon(
                    //           Icons.account_circle,
                    //           size: 40,
                    //         )
                    //       : Container(),
                    // ),
                    // SizedBox(width: 10),
                    // Text(
                    //   'dd',
                    //   //  LoginController().myUser?.nickname ??
                    //   //     LoginController().myUser?.correo!
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.white70,
                    //   ),
                    // )
                  ],
                ),
                // child: Text(
                //   'Sign Out',
                //   style: TextStyle(
                //     fontSize: 20,
                //     color: Colors.white,
                //   ),
                // ),
              ),
            ),
          )
        : Container(
            width: double.maxFinite,
            child: TextButton(
              // color: Colors.black,
              // hoverColor: Colors.blueGrey[800],
              // highlightColor: Colors.blueGrey[700],
              style: TextButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AuthDialog(),
                );
                // setState(() {
                // controller.userEmail;
                // });
              },
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15),
              // ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
