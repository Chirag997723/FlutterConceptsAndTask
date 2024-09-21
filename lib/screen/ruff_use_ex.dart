import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerList extends StatefulWidget {
  @override
  _AudioPlayerListState createState() => _AudioPlayerListState();
}

class Song {
  final String title;
  final String url;
  bool isPlaying;

  Song({required this.title, required this.url, this.isPlaying = false});
}


class _AudioPlayerListState extends State<AudioPlayerList> {
  final List<Song> songs = [
    Song(title: 'Song 1', url: 'https://example.com/song1.mp3'),
    Song(title: 'Song 2', url: 'https://example.com/song2.mp3'),
    Song(title: 'Song 3', url: 'https://example.com/song3.mp3'),
  ];

  AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;

  void _playPauseSong(Song song) {
    if (_currentSong == song) {
      if (song.isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.resume();
      }
      setState(() {
        song.isPlaying = !song.isPlaying;
      });
    } else {
      _audioPlayer.setSourceUrl(song.url);
      setState(() {
        if (_currentSong != null) {
          _currentSong!.isPlaying = false;
        }
        song.isPlaying = true;
        _currentSong = song;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<String> imageURL = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player List'),
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.4,
        ),
        itemCount: imageURL.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(imageURL[index],
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; 
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
