import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search by title or description',
            hintStyle: TextStyle(color: Colors.white60),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
        ),
      ),
      body: _searchQuery.isEmpty
          ? const Center(
              child: Text(
                'Search for artworks or artists here',
                style: TextStyle(color: Colors.white60),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('artworks')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final artworks = snapshot.data!.docs.where((doc) {
                  final title = doc['title'].toString().toLowerCase();
                  final description =
                      doc['description'].toString().toLowerCase();
                  return title.contains(_searchQuery) ||
                      description.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: artworks.length,
                  itemBuilder: (context, index) {
                    final artwork = artworks[index];
                    final imageUrl = artwork['imageUrl'];
                    final title = artwork['title'];
                    final description = artwork['description'];

                    return Column(
                      children: [
                        Card(
                          color: Colors
                              .black, // Set card background color to black
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: MediaQuery.of(context)
                                    .size
                                    .width, // Ensure the image is square
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  description,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.white, // Set divider color to white
                          thickness: 1.0, // Set thickness of the divider
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
