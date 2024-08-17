import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class AudioList extends StatefulWidget {
  @override
  State<AudioList> createState() => _AudioListState();
}

class Song {
  final String title;
  final String url;
  bool isPlaying;

  Song({required this.title, required this.url, this.isPlaying = false});
}

class _AudioListState extends State<AudioList>
    with SingleTickerProviderStateMixin {
  bool _loading = false;
  AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Song> songs = [];
  Song? _currentSong;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _loading = true;
    initAsync();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> initAsync() async {
    if (await requestStoragePermission()) {
      Directory folder = Directory('/storage/emulated/0/Download');
      if (await folder.exists()) {
        List<FileSystemEntity> files = folder.listSync();
        for (var file in files) {
          if (file.path.endsWith('.mp3')) {
            var audioFile =
                file.path.split('/storage/emulated/0/Download/').toString();
            var audioFile2 = audioFile.substring(2, audioFile.length - 1);
            songs.add(Song(title: audioFile2, url: file.path));
          }
        }
        setState(() {
          _loading = false;
        });
      } else {
        Fluttertoast.showToast(msg: 'iAmElse');
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AudioList',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  leading: song.isPlaying
                      ? RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.music_note,
                            color: Colors.black,
                          ),
                        )
                      : Icon(
                          Icons.music_note,
                          color: Colors.black,
                        ),
                  title: Text(song.title, maxLines: 2,),
                  trailing: Icon(
                    song.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onTap: () => _playPauseSong(song),
                );
              },
            ),
    );
  }

  void _playPauseSong(Song song) {
    if (_currentSong == song) {
      if (song.isPlaying) {
        audioPlayer.pause();
      } else {
        audioPlayer.resume();
      }
      setState(() {
        song.isPlaying = !song.isPlaying;
      });
    } else {
      File filePath = File(song.url);
      audioPlayer.play(DeviceFileSource(filePath.path));
      setState(() {
        if (_currentSong != null) {
          _currentSong!.isPlaying = false;
        }
        song.isPlaying = true;
        _currentSong = song;
      });
    }
  }

  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
