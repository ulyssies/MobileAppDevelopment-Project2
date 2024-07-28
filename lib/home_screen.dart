import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'upload_screen.dart'; // Import your upload screen
import 'search_screen.dart'; // Import your search screen
import 'profile_screen.dart'; // Import your profile screen

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Titles for each screen
  final List<String> _titles = [
    'Feed',
    'Search',
    'Upload',
    'Profile',
  ];

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomePage(), // Home
      const SearchScreen(), // Search
      const UploadScreen(), // Upload
      ProfileScreen(username: widget.username), // Profile
    ];
  }

  Widget _buildHomePage() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('artworks')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final artworks = snapshot.data!.docs;

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
                  color: Colors.black, // Set card background color to black
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_currentIndex == 3 ? widget.username : _titles[_currentIndex]),
        toolbarHeight: 80,
        titleTextStyle: const TextStyle(fontFamily: 'Montserrat', fontSize: 20),
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: _onItemTapped,
        backgroundColor: Colors.black, // Set a background color if needed
        selectedItemColor: Colors.white, // Color for selected item
        unselectedItemColor:
            const Color.fromARGB(255, 43, 43, 43), // Color for unselected items
        elevation: 2.0, // Shadow for the navigation bar
      ),
    );
  }
}
