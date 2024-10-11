import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Provider/news_provider.dart';
import '../../repositories/firebase_services.dart';
import '../widgets/news_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}


class _NewsScreenState extends State<NewsScreen> {
  String? countryCode;
  RemoteConfigService? remoteConfigService;
  @override
  void initState() {
    super.initState();
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfigService = RemoteConfigService(remoteConfig!);
    countryCode = remoteConfigService!.getCountryCode();
    Provider.of<NewsProvider>(context, listen: false).fetchNews(countryCode!.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context); // Access NewsProvider

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0C54BE), // Primary color remains the same
        actions: [
      Transform.rotate(
      angle: 45 * 3.14 / 180, // Rotate 45 degrees
        child: Icon(
          Icons.navigation_sharp,
          size: 20,
          color: Colors.white,
        ),
      ), // Send icon based on the image
          // SizedBox(width: 10),

            Row(
              children: [
                SizedBox(width: 5),
                Text(
                  countryCode??"IN",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
              ],
            ),
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
