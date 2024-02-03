import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Bookmark List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookmarkListScreen(),
    );
  }
}

class BookmarkListScreen extends StatefulWidget {
  @override
  _BookmarkListScreenState createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  List<bool> bookmarked = List.generate(10, (index) => false);
  List<bool> done = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Bookmarks'),
      ),
      backgroundColor:
          Colors.white, // Set the Scaffold background color to white
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: bookmarked.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin:
                      const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black.withOpacity(0.05), width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2), // Changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: done[index]
                                ? Colors.green
                                : Colors
                                    .grey[200], // Adjust the color as needed
                            child: Text('${index + 1}',
                                style: TextStyle(color: Colors.black)),
                          ),
                          title: Text(
                              'Item ${index + 1}'), // Replace with actual data
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          bookmarked[index]
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: bookmarked[index]
                              ? Colors.yellow[700]
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            bookmarked[index] = !bookmarked[index];
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement what happens when the button is pressed
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(70, 70, 122, 1), // Button color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(double.infinity, 50), // Button size
              ),
              child: Text(
                'สิ้นสุดการทำข้อสอบ',
                style: TextStyle(fontSize: 16), // Set the font size to 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}
