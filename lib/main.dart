import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        useMaterial3: true,
      ),
      home: const FavoriteSongsPage(),
    );
  }
}

class Song {
  final String title, artist, duration;
  const Song(this.title, this.artist, this.duration);
}

const songs = [
  Song('Is This How Feels Like?', 'Budiyasari', '4:05'),
  Song('Dinda', 'MASDO', '3:32'),
  Song('Teruntuk Mia', 'Nuh...', '3:17'),
  Song('Sesuatu Di Jogja', 'Adhitia Sofyan', '4:48'),
  Song('Nafas', 'Dipha Barus & Hindia', '3:26'),
];

class FavoriteSongsPage extends StatelessWidget {
  const FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D0D),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 14),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lagu Favorit',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${songs.length} lagu',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF9F67FF))),
                ],
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3B0764), Color(0xFF1A1A2E), Color(0xFF0D0D0D)],
                  ),
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Icon(Icons.library_music, color: Color(0xFF7C3AED), size: 48),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _SongTile(song: songs[i], number: i + 1),
                childCount: songs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  final Song song;
  final int number;

  const _SongTile({required this.song, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text('$number',
              style: const TextStyle(
                  color: Color(0xFF7C3AED), fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(song.title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(song.artist,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text(song.duration,
              style: const TextStyle(color: Color(0xFF9F67FF), fontSize: 13)),
        ],
      ),
    );
  }
}