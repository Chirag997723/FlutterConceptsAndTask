import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ImageList extends StatelessWidget {


  Future<List<String>> fetchImageUrls() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('Images/').listAll();
    final List<Reference> allFiles = result.items;

    List<String> urls = [];
    for (var file in allFiles) {
      final String url = await file.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FirebaseStorageImages'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => Get.to(FirebaseStorageCloud()),
              child: Icon(
                Icons.save_alt,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchImageUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No images found',
              style: TextStyle(fontSize: 20),
            ));
          } else {
            final List<String> urls = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: urls.length,
              itemBuilder: (context, index) {
                return urls.isEmpty
                    ? CircularProgressIndicator()
                    : Container(
                      height: 400,
                      margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(urls[index]),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15)),
                      );
              },
            );
          }
        },
      ),
    );
  }
}

class FirebaseStorageCloud extends StatefulWidget {
  @override
  State<FirebaseStorageCloud> createState() => _FirebaseStorageCloudState();
}

class _FirebaseStorageCloudState extends State<FirebaseStorageCloud> {
  String? imageUrl;
  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FirebaseStorage',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          imageUrl == null
              ? Icon(
                  Icons.person,
                  size: 200,
                  color: Colors.grey,
                )
              : Center(
                  child: Image.network(
                    imageUrl!,
                    height: Get.size.height * (.5),
                  ),
                ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton.icon(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(Icons.image),
                label: Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          if (isLoading)
            SpinKitThreeBounce(
              color: Colors.black,
              size: 20,
            )
        ],
      ),
    );
  }

  void pickImage() async {
    XFile? res = await imagePicker.pickImage(source: ImageSource.gallery);

    if (res != null) {
      uploadFirebase(File(res.path));
    } else {}
  }

  uploadFirebase(image) async {
    try {
      setState(() {
        isLoading = true;
      });
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Images/${DateTime.now().microsecondsSinceEpoch}.png');
      reference.putFile(image).whenComplete(
        () {
          Fluttertoast.showToast(msg: 'Image uloaded to 🔥base');
          isLoading = false;
        },
      );
      imageUrl = await reference.getDownloadURL();
      setState(() {});
    } catch (e) {
      print('error -->$e');
    }
  }
}
