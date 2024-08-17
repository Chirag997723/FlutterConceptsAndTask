import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:http/http.dart' as http;

class SmallTaks extends StatefulWidget {
  @override
  State<SmallTaks> createState() => _SmallTaksState();
}

class _SmallTaksState extends State<SmallTaks> {
  var taskName = [
    'WebView',
    'ChromeUrl',
    'SaveImage',
    'CopyShare',
    'CustomDialog',

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'appHeading',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: taskName.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(taskName[index]),
            leading: Icon(Icons.insert_emoticon),
            subtitle: Text(index.toString()),
            onTap: () {
              switch (index) {
                case 0:
                  Get.to(WebViewScreen());
                  break;
                case 1:
                  Get.to(ChromeUrl());
                  break;
                case 2:
                  Get.to(SaveImage());
                  break;
                case 3:
                  Get.to(CopyShare());
                  break;
                case 4:
                  Get.to(CustomDialog());
                  break;
              }
            },
          );
        },
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'This is a custom dialog',textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'It has an overlapping design',
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
          Positioned(
            top: -40,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 40,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://docs.flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WebViewScreen'),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          loadingPercentage < 100
              ? LinearProgressIndicator(
                  color: Colors.red,
                  value: loadingPercentage / 100.0,
                )
              : Container()
        ],
      ),
    );
  }
}

class ChromeUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch URL in Chrome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchUrl(Uri.parse('https://docs.flutter.dev')).then(
              (value) {
                Future.delayed(
                    const Duration(seconds: 3), () => Navigator.pop(context));
              },
            );
          },
          child: Text('Open URL'),
        ),
      ),
    );
  }
}

class SaveImage extends StatefulWidget {
  static const _url = 'https://i.ibb.co/0QM2HXK/Shiv-lingam-Tripundra.jpg';

  const SaveImage({super.key});

  @override
  State<SaveImage> createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Permissions are granted, proceed with your operation
    } else {
      // Handle the case where permissions are denied
      Fluttertoast.showToast(msg: 'Permission NA');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save image to disk'),
        actions: [
          IconButton(
            onPressed: () {
              var fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
              downloadImage(SaveImage._url, fileName);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(SaveImage._url),
          ),
        ),
      ),
    );
  }

  Future<void> downloadImage(String url, String fileName) async {
    try {
      // Request storage permissions
      await requestPermissions();

      // Get the directory to save the image
      Directory directory = Directory('/storage/emulated/0/Download');

      String filePath = '${directory.path}/$fileName';

      // Download the image
      final response = await http.get(Uri.parse(url));

      // Save the image to the file
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      Fluttertoast.showToast(msg: 'Image downloaded');
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}

class CopyShare extends StatelessWidget {
  String message =
      'GetX is a popular Flutter package that provides tools for state management, routing, and dependency injection. It can help simplify complex state management scenarios, making codebases more efficient and maintainable.';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CopyShare',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SelectableText(message),
          OutlinedButton.icon(
              onPressed: () {
                Share.share(message);
              },
              label: Icon(Icons.share))
        ],
      ),
    );
  }
}
