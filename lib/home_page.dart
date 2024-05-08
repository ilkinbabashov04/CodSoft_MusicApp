// ignore_for_file: dead_code

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music_app/music_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; // Changed initialization to 0
  late AssetsAudioPlayer player = AssetsAudioPlayer(); // Initialize player
  List<bool> isPlayingList =
      List.filled(15, false); // Track playing state for each card
  List<bool> isFavoriteList =
      List.filled(15, false); // Track favorite state for each card
  List<bool> isPlaylistList = List.filled(15, false);

  List<String> favoriteSongNames = [];
  List<String> favoriteArtistNames = [];
  List<String> favoriteAudioAssets = [];
  List<String> favoriteImageAssets = [];

  List<String> playlistSongNames = [];
  List<String> playlistArtistNames = [];
  List<String> playlistAudioAssets = [];
  List<String> playlistImageAssets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 7, 82),
      body: Padding(
        padding: EdgeInsets.only(top: 45),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 35, 1, 78),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, 0.9),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 31, 2, 156),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 150, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              // Column to hold the search field and buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.3),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("Favourites", 0),
                      _buildButton("Tracks", 1),
                      _buildButton("Playlist", 2),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // ListView for music cards
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        // Music cards for Favourites section
                        if (selectedIndex == 0) ...[
                          for (int i = 0; i < favoriteSongNames.length; i++)
                            _buildMusicCard(
                              favoriteSongNames[i],
                              favoriteArtistNames[i],
                              favoriteAudioAssets[i],
                              favoriteImageAssets[i],
                              i,
                            ),
                        ],

                        if (selectedIndex == 2) ...[
                          for (int i = 0; i < playlistSongNames.length; i++)
                            _buildMusicCard(
                              playlistSongNames[i],
                              playlistArtistNames[i],
                              playlistAudioAssets[i],
                              playlistImageAssets[i],
                              i,
                            )
                        ],
                        // Music cards for Tracks section
                        if (selectedIndex == 1) ...[
                          _buildMusicCard(
                              'Azərbaycan',
                              'Rəşid Behbudov',
                              'assets/audio/azerbaija.mp3',
                              'assets/images/azerbaijan.jpg',
                              3),
                          _buildMusicCard(
                              'Moonlight',
                              'Scott Buckley',
                              'assets/audio/adel.mp3',
                              'assets/images/scott.jpg',
                              4),
                          _buildMusicCard(
                              'Alla Turca',
                              'Mozart',
                              'assets/audio/mozart.mp3',
                              'assets/images/mozart.png',
                              5),
                          _buildMusicCard(
                              'Set Fire to the Rain',
                              'Adele',
                              'assets/audio/adele.mp3',
                              'assets/images/adele.jpg',
                              6),
                          _buildMusicCard(
                              'Aynali Kemer',
                              'Bariş Manço',
                              'assets/audio/baris.mp3',
                              'assets/images/baris.jpg',
                              7),
                          _buildMusicCard(
                              'Let Me Down Slowly',
                              'Alec Benjamin',
                              'assets/audio/let.mp3',
                              'assets/images/let.jpg',
                              8),
                          _buildMusicCard(
                              'See You Again',
                              'Charlie Puth',
                              'assets/audio/see.mp3',
                              'assets/images/see.jpg',
                              9),
                          // Add more music cards here
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 36, 7, 82),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlist',
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : Colors.white54,
            fontSize: selectedIndex == index ? 20 : null,
          ),
        ),
      ),
    );
  }

  Widget _buildMusicCard(
    String songName,
    String artistName,
    String audioAsset,
    String imageAsset,
    int cardIndex,
  ) {
    bool isAlreadyInFavorites = favoriteSongNames.contains(songName);
    bool isAlreadyInPlaylist = playlistSongNames.contains(songName);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicDetailPage(
              songName: songName,
              artistName: artistName,
              audioAsset: audioAsset,
              imageAsset: imageAsset,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // Add border for separation
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              child: Image.asset(imageAsset),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    songName,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    artistName,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isAlreadyInFavorites ? Icons.favorite : Icons.favorite_border,
                color: isAlreadyInFavorites ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (isAlreadyInFavorites) {
                    int indexToRemove = favoriteSongNames.indexOf(songName);
                    if (indexToRemove != -1) {
                      favoriteSongNames.removeAt(indexToRemove);
                      favoriteArtistNames.removeAt(indexToRemove);
                      favoriteAudioAssets.removeAt(indexToRemove);
                      favoriteImageAssets.removeAt(indexToRemove);
                    }
                  } else {
                    favoriteSongNames.add(songName);
                    favoriteArtistNames.add(artistName);
                    favoriteAudioAssets.add(audioAsset);
                    favoriteImageAssets.add(imageAsset);
                  }
                  isFavoriteList[cardIndex] = !isFavoriteList[cardIndex];
                });
              },
            ),
            IconButton(
              icon: Icon(
                isAlreadyInPlaylist
                    ? Icons.playlist_add_check
                    : Icons.playlist_add,
                color: isAlreadyInPlaylist ? Colors.green : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (isAlreadyInPlaylist) {
                    int indexToRemove = playlistSongNames.indexOf(songName);
                    if (indexToRemove != -1) {
                      playlistSongNames.removeAt(indexToRemove);
                      playlistArtistNames.removeAt(indexToRemove);
                      playlistAudioAssets.removeAt(indexToRemove);
                      playlistImageAssets.removeAt(indexToRemove);
                    }
                  } else {
                    playlistSongNames.add(songName);
                    playlistArtistNames.add(artistName);
                    playlistAudioAssets.add(audioAsset);
                    playlistImageAssets.add(imageAsset);
                  }
                  isPlaylistList[cardIndex] = !isPlaylistList[cardIndex];
                });
              },
            ),
            IconButton(
              icon: Icon(
                  isPlayingList[cardIndex] ? Icons.stop : Icons.play_arrow),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  if (isPlayingList[cardIndex]) {
                    player.stop();
                  } else {
                    player.open(
                      Audio(audioAsset),
                      autoStart: true,
                      showNotification: true,
                      respectSilentMode: false,
                    );
                  }
                  isPlayingList[cardIndex] = !isPlayingList[cardIndex];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
