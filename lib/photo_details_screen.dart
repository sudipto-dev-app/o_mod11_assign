import 'package:o_mod11_assign/main.dart';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  PhotoDetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<void>(
              future: precacheImage(NetworkImage(photo.url), context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Image.network(photo.url),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text('Title: ${photo.title}'),
            Center(
              child: Text('ID: ${photo.id}'),
            ),
          ],
        ),
      ),
    );
  }
}
