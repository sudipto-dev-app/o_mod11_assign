import 'dart:convert';
import 'package:o_mod11_assign/photo_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const PhotoListScreen(),
    );
  }
}

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        setState(() {
          photos = parsedData.map((json) => Photo.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: photos.isNotEmpty
          ? ListView.separated(
        itemCount: photos.length,
        separatorBuilder: (context, index) =>
            const Divider(), // Add a Divider between items
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(photos[index].title),
            leading: Image.network(photos[index].thumbnailUrl),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PhotoDetailScreen(photo: photos[index]),
                ),
              );
            },
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  Photo(
      {required this.id,
        required this.title,
        required this.thumbnailUrl,
        required this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      url: json['url'],
    );
  }
}
