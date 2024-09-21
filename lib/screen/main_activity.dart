import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_practice_app/bloc/theme/theme_bloc.dart';
import 'package:flutter_practice_app/bloc/theme/theme_event.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_bloc.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_event.dart';
import 'package:flutter_practice_app/bloc/txt_color/txt_color_state.dart';
import 'package:flutter_practice_app/screen/photo_gallery.dart';
import 'package:flutter_practice_app/screen/ruff_use_ex.dart';
import 'package:flutter_practice_app/screen/example/api_call.dart';
import 'package:flutter_practice_app/screen/example/gridview_builder_ex.dart';
import 'package:flutter_practice_app/screen/example/listview_builder_ex.dart';
import 'package:flutter_practice_app/screen/example/shared_preferences_ex.dart';
import 'package:flutter_practice_app/screen/example/simple_example_app.dart';
import 'package:flutter_practice_app/firebase/fireStoreDb.dart';
import 'package:flutter_practice_app/firebase/firebaseStorage.dart';
import 'package:flutter_practice_app/firebase/gmailFirebase.dart';
import 'package:flutter_practice_app/firebase/messagingExample.dart';
import 'package:flutter_practice_app/firebase/phoneOtpFirebase.dart';
import 'package:flutter_practice_app/firebase/realtimeDatabase.dart';
import 'package:flutter_practice_app/screen/loginSignupPre/editEmailPre.dart';
import 'package:flutter_practice_app/screen/loginSignupPre/loginSignupPre.dart';
import 'package:flutter_practice_app/provider/theme_provider.dart';
import 'package:flutter_practice_app/screen/smallTaks.dart';
import 'package:flutter_practice_app/screen/displayDataBase.dart';
import 'package:flutter_practice_app/screen/state_management.dart';
import 'package:flutter_practice_app/screen/ui/method_chanel.dart';
import 'package:flutter_practice_app/screen/ui/screen_SelectionTask.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MainActivity extends StatelessWidget {
  var conceptList = [
    'Human Emotion',
    'Gridview Builder',
    'SharedPrefer',
    'Ruff Use',
    'Photo Gallery',
    'Audio',
    'PhoneOtp\nFirebase',
    'GmailFirebase',
    'FirebaseStorage',
    'RealtimeDatabase',
    'FireStoreDb',
    'MessagingExample',
    'loginSignupPre',
    'EditEmailPre',
    'displayDataBase',
    'SmallTaks',
    'ApiCalling',
    'StateManagement',
    'MethodChanel',
    'SelectionTask',
  ];

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final pre = await SharedPreferences.getInstance();
                pre.setBool('userLogin', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contex) => LoginSignupPre()),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          IconButton(
              icon: Icon(Icons.light_mode),
              onPressed: () {
                // themeProvider.toggleTheme
                context.read<ThemeBloc>().add(ThemeToggel());
              }),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Pick a color'),
                    content: SingleChildScrollView(
                      child: BlocBuilder<TxtColorBloc, TxtColorState>(
                        builder: (context, state) {
                          return ColorPicker(
                            pickerColor: state.color,
                            // Provider.of<ThemeProvider>(context,
                            //         listen: false)
                            //     .color,
                            onColorChanged: (color) {
                              context
                                  .read<TxtColorBloc>()
                                  .add(TextColorChange(color: color));
                              // Provider.of<ThemeProvider>(context, listen: false)
                              //     .setColor(color);
                            },
                          );
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Done'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.ac_unit))
        ],
        title: Center(child: BlocBuilder<TxtColorBloc, TxtColorState>(
          builder: (context, state) {
            return Text(
              'appHeading1',
              style: TextStyle(
                  fontSize: 18,
                  // color: Provider.of<ThemeProvider>(context).color,
                  color: state.color,
                  fontWeight: FontWeight.bold),
            );
          },
        )),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: WillPopScope(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: conceptList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(ListviewBuilderEx());
                          break;
                        case 1:
                          Get.to(GridviewBuilderEx());
                          break;
                        case 2:
                          Get.to(SharedPreferencesEx());
                          break;
                        case 3:
                          Get.to(AudioPlayerList());
                          break;
                        case 4:
                          Get.to(ImageGalary());
                          break;
                        case 5:
                          Get.to(AudioList());
                          break;
                        case 6:
                          Get.to(PhoneOtpFirebase());
                          break;
                        case 7:
                          Get.to(GmailFirebase());
                          break;
                        case 8:
                          Get.to(ImageList());
                          break;
                        case 9:
                          Get.to(RealtimeDatabase());
                          break;
                        case 10:
                          Get.to(FireStoreDb());
                          break;
                        case 11:
                          Get.to(MessagingExampleApp());
                          break;
                        case 12:
                          Get.to(LoginSignupPre());
                          break;
                        case 13:
                          Get.to(EditEmailPre());
                          break;
                        case 14:
                          Get.to(displayDataBase());
                          break;
                        case 15:
                          Get.to(SmallTaks());
                          break;
                        case 16:
                          Get.to(MVCApiCall());
                          break;
                        case 17:
                          Get.to(StateManagement());
                          break;
                        case 18:
                          Get.to(ProductsPage());
                          break;
                        case 19:
                          Get.to(CityPage());
                          break;
                      }
                    },
                    child: Card(
                      color: Colors.white10,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/images/man.png')),
                          Container(
                            height: 10,
                          ),
                          Text('${conceptList[index]}'),
                        ],
                      )),
                    ),
                  ),
                );
              }),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'exit warning');
      return Future.value(false);
    }
    return Future.value(true);
  }
}

