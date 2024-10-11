import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Ensure you import this
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import '../../Provider/news_provider.dart';
import '../widgets/news_card.dart';  // Assuming this widget is your custom news card widget

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch news when the screen is initialized
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context); // Access NewsProvider

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: GoogleFonts.poppins(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
          // Poppins font as you had before
        ),
        backgroundColor: Color(0xFF0C54BE), // Primary color remains the same
        actions: [
          Icon(Icons.send, color: Colors.white), // Send icon based on the image
          SizedBox(width: 10),
          Text(
            'IN',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 15),
        ],
      ),
      backgroundColor: Color(0xFFF5F9FD),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Headlines',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: newsProvider.isLoading
                  ? Center(child: CircularProgressIndicator()) // Show loading indicator
                  : newsProvider.errorMessage != null
                  ? Center(child: Text(newsProvider.errorMessage!)) // Show error message
                  : ListView.builder(
                itemCount: newsProvider.articles.length, // Use the actual number of articles
                itemBuilder: (context, index) {
                  final article = newsProvider.articles[index]; // Get the article
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: NewsCard(article: article), // Pass article to your custom widget
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
