import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice_app/screen/home_screen.dart';
import 'package:flutter_practice_app/app_constants/save_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

/// The main widget of example app
class ImageGalary extends StatefulWidget {
  @override
  _ImageGalaryState createState() => _ImageGalaryState();
}

class _ImageGalaryState extends State<ImageGalary> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums = await PhotoGallery.listAlbums();
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool>  _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        return true;
      } else {
        openAppSettings();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Albums'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                double gridWidth = (constraints.maxWidth - 20) / 3;
                double gridHeight = gridWidth + 33;
                double ratio = gridWidth / gridHeight;
                return Container(
                  padding: EdgeInsets.all(5),
                  child: GridView.count(
                    childAspectRatio: ratio,
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    children: <Widget>[
                      ...?_albums?.map(
                        (album) => GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AlbumPage(album)),
                          ),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  color: Colors.grey[300],
                                  height: gridWidth,
                                  width: gridWidth,
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: AlbumThumbnailProvider(
                                      album: album,
                                      highQuality: true,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 2.0),
                                child: Text(
                                  album.name ?? "Unnamed Album",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    height: 1.2,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 2.0),
                                child: Text(
                                  album.count.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    height: 1.2,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

/// The album page widget
class AlbumPage extends StatefulWidget {
  /// Album object to show in the page
  final Album album;

  /// The constructor of AlbumPage
  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.album.name ?? "Unnamed Album"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          ...?_media?.map(
            (medium) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewerPage(medium)),
              ),
              child: Container(
                color: Colors.grey[300],
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: ThumbnailProvider(
                    mediumId: medium.id,
                    mediumType: medium.mediumType,
                    highQuality: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isVideo(String path) {
    final videoExtensions = [
      'mp4',
      'avi',
      'mov',
      'wmv',
      'flv',
      'mkv',
      'webm',
      'mpeg'
    ];
    final extension = path.split('.').last.toLowerCase();
    return videoExtensions.contains(extension);
  }
}

/// The viewer page widget
class ViewerPage extends StatelessWidget {
  /// The medium object to show in the page
  final Medium medium;

  /// The constructor of ViewerPage
  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: date != null ? Text(date.toLocal().toString()) : null,
      ),
      body: Container(
        alignment: Alignment.center,
        child: medium.mediumType == MediumType.image
            ? Column(
                children: [
                  FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: PhotoProvider(mediumId: medium.id),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final File file =
                            await PhotoGallery.getFile(mediumId: medium.id);
                        Share.shareFiles([file.path],
                            text: 'Check out this image!');
                      },
                      child: Text('Share')),
                  ElevatedButton(
                      onPressed: () async {
                        final File file =
                            await PhotoGallery.getFile(mediumId: medium.id);

                        String currentPath = file.path;
                        var lastSeparator =
                            currentPath.lastIndexOf(Platform.pathSeparator);
                        String fileExtension = ".jpeg";
                        String fileName =
                            Random().nextInt(1000000000).toString() +
                                fileExtension;
                        String newPath =
                            currentPath.substring(0, lastSeparator + 1) +
                                fileName;
                        await renameFile(currentPath, newPath);
                      },
                      child: Text('Edit')),
                  ElevatedButton(
                      onPressed: () {
                        PhotoGallery.deleteMedium(mediumId: medium.id);
                      },
                      child: Text('Delete')),
                  ElevatedButton(
                      onPressed: () async {
                        final File file =
                            await PhotoGallery.getFile(mediumId: medium.id);

                        String result;
                        try {
                          result = await AsyncWallpaper.setWallpaperFromFile(
                            filePath: file.path,
                            wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                            goToHome: false,
                            toastDetails: ToastDetails.success(),
                            errorToastDetails: ToastDetails.error(),
                          )
                              ? 'Wallpaper set'
                              : 'Failed to get wallpaper.';
                        } on PlatformException {
                          result = 'Failed to get wallpaper.';
                        }
                      },
                      child: Text('SetWallpaper')),
                ],
              )
            : VideoProvider(
                mediumId: medium.id,
              ),
      ),
    );
  }

  Future<void> renameFile(String currentPath, String newPath) async {
    requestPermissions();
    try {
      final file = File(currentPath);
      if (await file.exists()) {
        await file.rename(newPath);
        Fluttertoast.showToast(msg: 'File renamed successfully');
      } else {
        Fluttertoast.showToast(msg: 'File does not exist');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error renaming file: $e');
    }
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Storage permission is granted
    } else {
      // Handle permission denied
    }

    if (Platform.isAndroid &&
        await Permission.manageExternalStorage.request().isGranted) {
      // Manage External Storage permission is granted
    } else {
      // Handle permission denied
    }
  }
}

/// The video provider widget
class VideoProvider extends StatefulWidget {
  /// The identifier of medium
  final String mediumId;

  /// The constructor of VideoProvider
  const VideoProvider({
    required this.mediumId,
  });

  @override
  _VideoProviderState createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  VideoPlayerController? _controller;
  File? _file;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
      _controller = VideoPlayerController.file(_file!);
      _controller!.initialize().then((_) {
        setState(() {});
      });
    } catch (e) {
      print("Failed : $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      });
                    },
                    child: Icon(
                      _controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SaveFile().file = _file.toString();
                      Get.to(HomePage());
                    },
                    child: Text('StartVideo'),
                  ),
                ],
              ),
            ],
          );
  }
}
