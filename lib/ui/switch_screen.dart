import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice_app/bloc/switch/switch_bloc.dart';
import 'package:flutter_practice_app/bloc/switch/switch_event.dart';
import 'package:flutter_practice_app/bloc/switch/switch_state.dart';
import 'package:image_picker/image_picker.dart';

class SwitchScreen extends StatefulWidget {
  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SwitchScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notification'),
              BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.isSwitch != current.isSwitch,
                builder: (context, state) {
                  return Switch(
                    value: state.isSwitch,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(ToggelNotifi());
                    },
                  );
                },
              ),
            ],
          ),
          BlocBuilder<SwitchBloc, SwitchState>(
            buildWhen: (previous, current) => previous.slider != current.slider,
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.all(8.0),
                height: 200,
                width: double.infinity,
                color: Colors.deepOrange.withOpacity(state.slider),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Slider(
                value: state.slider,
                onChanged: (value) {
                  context.read<SwitchBloc>().add(SliderEvent(slider: value));
                },
              );
            },
          ),
          // Usage in your widget
          ElevatedButton(
            onPressed: () async {
              File? imageFile = await pickImage();
              if (imageFile != null) {
                await uploadImageToImgBB(imageFile);
              } else {
                print("No image selected");
              }
            },
            child: Text("Pick, Upload, and Access Image URL"),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImageToImgBB(File imageFile) async {
    Dio dio = Dio();
    String apiKey =
        "ede0e0c2a3f9e8994d75233336b09f05"; // Replace with your ImgBB API key
    String apiUrl = "https://api.imgbb.com/1/upload";

    FormData formData = FormData.fromMap({
      "key": apiKey,
      "image":
          await MultipartFile.fromFile(imageFile.path, filename: "upload.jpg"),
    });

    try {
      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        String imageUrl = response.data['data']['url'];
        print("Image uploaded successfully. URL: $imageUrl");

        // You can now use this URL, for example, to display the image
        // You might want to return the URL or pass it to another widget
      } else {
        print("Image upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
